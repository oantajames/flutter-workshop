//todo - create a login
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

// A plugin: wrapper over the native shared preferences from both platforms(IOS,ANDROID)
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager {
  static const String LOGIN_SERVICE = 'https://api.github.com/authorizations';
  static const String KEY_OATUH_TOKEN = 'AUTH_TOKEN';
  static const String KEY_USER_NAME = 'USER_NAME';

  final Logger log = new Logger('AuthenticationManager');

//Github related - you will have them from the github console, after you create an oauth github app
  final String _clientId = '0c3309f29b2560e05218';
  final String _clientSecret = '1d8f0f0626760ba3b6b30d5140f6cc95735c642b';

  bool _initialized;
  bool _loggedIn;

  String _username;
  AuthClient _authClient;

  // The interface for HTTP clients that take care of maintaining persistent
  /// connections across multiple requests to the same server.
  Client _client = new Client();

  bool get loggedIn => _loggedIn;

  bool get initialized => _initialized;

  AuthClient get authClient => _authClient;

  // Initializing the Authentication Manager
  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString(KEY_USER_NAME);
    String oAuthToken = preferences.getString(KEY_OATUH_TOKEN);

    if (userName == null || oAuthToken == null) {
      _loggedIn = false;
      await logout();
    } else {
      _loggedIn = true;
      _username = userName;
      _authClient = new AuthClient(_client, oAuthToken);
    }
    _initialized = true;
  }

  Future logout() async {
    await _saveToken(null, null);
    _loggedIn = false;
  }

  _saveToken(String userName, token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(KEY_USER_NAME, userName);
    preferences.setString(KEY_OATUH_TOKEN, token);
    await preferences.commit();
    _username = userName;
    _authClient = new AuthClient(_client, token);
  }

  Future<bool> login(String userName, String password) async {
    var token = _getEncodedAuthorization(userName, password);
    final requestHeader = {'Authorization': 'Basic ${token}'};

    final requestBody = JSON.encode({
      'clinet_id': _clientId,
      'client_secret': _clientSecret,
      'scopes': ['user', 'repo', 'notifications']
    });

    //save the response for the request in a var
    final loginResponse = await _client
        .post(LOGIN_SERVICE, headers: requestHeader, body: requestBody)
        .catchError((e) => log.severe(e.toString()))
        .whenComplete(_client.close);

    if (loginResponse.statusCode == 201 || loginResponse.statusCode == 200) {
      final bodyJson = JSON.decode(loginResponse.body);
      await _saveToken(userName, bodyJson['token']);
      _loggedIn = true;
    } else {
      //todo - log something if there's an error - like not good password, or username etc.
      _loggedIn = false;
    }

    return _loggedIn;
  }

  String _getEncodedAuthorization(String userName, String password) {
    final authorizationBytes = UTF8.encode('${userName}:${password}');
    return BASE64.encode(authorizationBytes);
  }
}

// The HTTP client for the oauth for Github
class AuthClient extends BaseClient {
  final Client _client;
  final String _token;

  AuthClient(this._client, this._token);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = _token;
    return _client.send(request);
  }
}
