import 'package:flutter/material.dart';
import 'package:flutterworkshop/networking/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/SplashScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
//  final routes = <String, WidgetBuilder>{
//    '/login': (context) => LoginScreen(),
//    '/repository': (context) => FeedScreen(),
//    '/splash': (context) => SplashScreen(_authManager);
//  };
  final AuthenticationManager _authManager = new AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          primaryColorLight: Colors.white),
      home: new SplashScreen(_authManager),
//      routes: routes,
    );
  }
}
