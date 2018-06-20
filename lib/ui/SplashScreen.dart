import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterworkshop/networking/AuthenticationManager.dart';
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
      //todo 2: delay the push action on the navigtor with 3 seconds
      Navigator
          .of(context)
          .push(new MaterialPageRoute(builder: (context) => FeedScreen()));
    } else {
      //todo 3: delay the push action on the navigtor with 3 seconds
      Navigator
          .of(context)
          .push(new MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  //todo 1: wrap the container inside a Hero widget and set the tag of the widget to githubLogo
  final logoWithHeroAnimation = new Container(
    width: 200.0,
    height: 200.0,
    child: new Container(
      child: new Column(
        children: <Widget>[
          new Image.asset("assets/Shape.png"),
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Image.asset("assets/Github-Logo.png"),
          )
        ],
      ),
    ),
  );

  final logo = new Container(
    width: 200.0,
    height: 200.0,
    child: new Container(
      child: new Column(
        children: <Widget>[
          new Image.asset("assets/Shape.png"),
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Image.asset("assets/Github-Logo.png"),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: LoginScreen.colorBlue,
        body: new Center(child: logoWithHeroAnimation));
  }
}

//todo 4: create a custom Route that uses Fade Animation
// You will need to extend from MaterialPageRoute<T> and overide buildTransitions
//todo 5: Create the FadeTransition inside the buildTransition method
//todo 6: overide the transitionDuration so it will take 1 second
class MyCustomRoute {
  //todo
}
