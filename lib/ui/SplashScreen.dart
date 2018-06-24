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
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator
            .of(context)
            .push(new MyCustomRoute(builder: (context) => FeedScreen()));
      });
    } else {
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator
            .of(context)
            .push(new MyCustomRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  final logoWithHeroAnimation = new Hero(
      tag: "logoHero",
      child: Container(
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
      ));

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

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => new Duration(milliseconds: 1000);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    //todo - solve the bug related to the black line appearing on the right side
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
