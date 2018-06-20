import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  static String imageUrl =
      "https://images.unsplash.com/photo-1495078065017-564723e7e3e7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=09093dcdf66dbcd2397b9dc19384a899&auto=format&fit=crop&w=1600&q=80";

  FeedItem(this.userName, this.action, this.date);

  final String userName;
  final String action;
  final String date;

  @override
  Widget build(BuildContext context) {
    final profileImage = new Container(
      width: 80.0,
      height: 80.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: new NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
      ),
    );

    final userNameWidget = new Container(
        alignment: Alignment.topLeft,
        child: new Text(
          userName,
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ));

    final actionWidget = new Text(action,
        style: new TextStyle(
            fontSize: 13.0,
            color: Colors.black,
            fontWeight: FontWeight.normal));

    Row createDynamicIconRow(IconData icon, String text) {
      return new Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20.0,
          ),
          new Text(text,
              style: new TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w100))
        ],
      );
    }

    final infoRow = new Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          createDynamicIconRow(Icons.euro_symbol, "HTML"),
          createDynamicIconRow(Icons.star, "12.00"),
          new Text(date,
              style: new TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w100)),
        ],
      ),
    );

    final textColumn = new Expanded(
        child: new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[userNameWidget, actionWidget, infoRow],
            )));

    return new Container(
        height: 140.0,
        child: new Card(
            color: Colors.white,
            elevation: 5.0,
            margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: new Padding(
              padding: EdgeInsets.all(15.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[profileImage, textColumn],
              ),
            )));
  }
}
