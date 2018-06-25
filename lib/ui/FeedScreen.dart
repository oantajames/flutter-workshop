import 'package:flutter/material.dart';
import 'package:flutterworkshop/networking/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/LoginScreen.dart';
import 'package:flutterworkshop/ui/SplashScreen.dart';
import 'package:flutterworkshop/ui/items/FeedItem.dart';

class FeedScreen extends StatefulWidget {
  static String tag = 'repositories-screen';

  @override
  State<StatefulWidget> createState() => new _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final int size = 30;

  List<FeedItem> feedItems = [];
  AuthenticationManager authManager = new AuthenticationManager();

  @override
  void initState() {
    super.initState();
    authManager.init();
    initFeed();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: feedItems,
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            //todo navigator
          },
          child: new Icon(Icons.person)),
      appBar: new AppBar(
        backgroundColor: LoginScreen.colorBlue,
        title: new Text("Github Feed"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                _logOut();
              })
        ],
      ),
    );
  }

  void _logOut() async {
    await authManager.logout();
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  List<Widget> initFeed() {
    for (int i = 0; i < 100; i++) {
      feedItems.add(new FeedItem("UserName ${i}", "Forke ${i}", "1${i}/${i}"));
    }
    return feedItems;
  }
}
