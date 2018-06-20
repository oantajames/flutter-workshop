import 'package:flutter/material.dart';
import 'package:flutterworkshop/ui/LoginScreen.dart';
import 'package:flutterworkshop/ui/items/FeedItem.dart';

class FeedScreen extends StatefulWidget {
  static String tag = 'repositories-screen';

  @override
  State<StatefulWidget> createState() => new _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final int size = 30;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6"),
          new FeedItem(
              "James Howe",
              "forked  hanuor/phantomjs from ariya/phantomjs 5 hours ago",
              "Update June 6")
        ],
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
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => LoginScreen()));
              })
        ],
      ),
    );
  }
}
