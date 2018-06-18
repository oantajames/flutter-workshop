import 'package:flutter/material.dart';
import 'package:flutterworkshop/interactor/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/FeedScreen.dart';
import 'package:flutterworkshop/ui/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  final AuthenticationManager _authManager;

  SplashScreen(this._authManager);

  @override
  State<StatefulWidget> createState() => new _SplashState(_authManager);
}

class _SplashState extends State<SplashScreen> {
  final AuthenticationManager _authManager;

  _SplashState(this._authManager);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _authManager.init();
    String route;
    if (_authManager.loggedIn) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => FeedScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(child: new CircularProgressIndicator()));
  }
}
