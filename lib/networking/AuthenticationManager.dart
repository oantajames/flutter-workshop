import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

//todo 1: import shared prefs package
// ** A plugin: wrapper over the native shared preferences from both platforms(IOS,ANDROID)

//import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager {
  static const String LOGIN_SERVICE = 'https://api.github.com/authorizations';

  static const String KEY_OATUH_TOKEN = 'AUTH_TOKEN';
  static const String KEY_USER_NAME = 'USER_NAME';

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

  //todo 2: Make this method from synchronous to asynchronous
  void init() {
    // todo : create a shared preferences instance and get the username and token from there
    String userName = "";
    String oAuthToken = "";

    //todo - check if the username and token is null
    if (userName == null || oAuthToken == null) {
      _loggedIn = false;
      //don't forget the await
      logout();
    } else {
      _loggedIn = true;
      _username = userName;
      _authClient = new OauthClient(_client, oAuthToken);
    }
    _initialized = true;
  }

  //todo 3: Make this method from synchronous to asynchronous
  void logout() {
    //don't forget the await
    _saveToken(null, null);
    _loggedIn = false;
  }

  _saveToken(String userName, token) {
    //todo 4: save the username and token in the shared preferences
    _username = userName;
    _authClient = new OauthClient(_client, token);
  }

  //todo 5: make the login method asynchronous
  bool login(String userName, String password) {
    var token = _getEncodedAuthorization(userName, password);
    final requestHeader = {'Authorization': 'Basic ${token}'};
    print(requestHeader);

    final requestBody = JSON.encode({
      'clinet_id': _clientId,
      'client_secret': _clientSecret,
      'scopes': ['user', 'repo', 'notifications']
    });

    //save the response for the request in a var
    //todo - using the authClient create a post request with the following params: LOGIN_SERVICE, requestHeader, reuqestBody
    //todo - when the req is completed, close the http client.
    final loginResponse = null;

    if (loginResponse.statusCode == 200) {
      final bodyJson = JSON.decode(loginResponse.body);
      //don't forget the await
      _saveToken(userName, bodyJson['token']);
      _loggedIn = true;
    } else {
      print(loginResponse.statusCode);
      _loggedIn = false;
    }
    print(loginResponse.reasonPhrase);
    return _loggedIn;
  }

  String _getEncodedAuthorization(String userName, String password) {
    final authorizationBytes = UTF8.encode('${userName}:${password}');
    return BASE64.encode(authorizationBytes);
  }
}

class OauthClient extends AuthClient {
  OauthClient(Client client, String token) : super(client, 'token ${token}');
}

abstract class AuthClient extends BaseClient {
  final Client _client;
  final String _token;

  AuthClient(this._client, this._token);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = _token;
    return _client.send(request);
  }
}
