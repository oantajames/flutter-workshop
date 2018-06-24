import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationManager {
  static const String LOGIN_SERVICE = 'https://api.github.com/authorizations';
  static const String KEY_OATUH_TOKEN = 'AUTH_TOKEN';
  static const String KEY_USER_NAME = 'USER_NAME';

  final Logger log = new Logger('AuthenticationManager');

  final String _clientId = '0c3309f29b2560e05218';
  final String _clientSecret = '89b327f9086cf787ceb6cd51859c1932ced0fb58';

  bool _initialized;
  bool _loggedIn;

  String _username;

  Client _client = new Client();

  bool get loggedIn => _loggedIn;

  bool get initialized => _initialized;

  String get username => _username;

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
  }

  Future<bool> login(String userName, String password) async {
    var token = _getEncodedAuthorization(userName, password);
    print(token);
    final requestHeader = {'Authorization': 'Basic ${token}'};

    final requestBody = json.encode({
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'scopes': ['user', 'repo', 'notifications']
    });


    final loginResponse = await _client
        .post(LOGIN_SERVICE, headers: requestHeader, body: requestBody)
        .catchError((e) => print(e.toString()))
        .whenComplete(_client.close);

    print(LOGIN_SERVICE);
    print(loginResponse.reasonPhrase);
    print(requestHeader);
    print(requestBody);
    print(loginResponse.body);

    if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
      final bodyJson = json.decode(loginResponse.body);
      await _saveToken(userName, bodyJson['token']);
      _loggedIn = true;
    } else {
      print(loginResponse.statusCode);
      log.severe(loginResponse.statusCode);
      _loggedIn = false;
    }
    return _loggedIn;
  }

  String _getEncodedAuthorization(String userName, String password) {
    print(userName + password);
    final authorizationBytes = utf8.encode('${userName}:${password}');
    return base64.encode(authorizationBytes);
  }
}

