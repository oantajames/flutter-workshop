import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileImage = new Row(
      children: <Widget>[
        new Expanded(child: new Image.asset("assets/microsoft.png")),
        new Expanded(
          child: new Column(
            children: <Widget>[],
          ),
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text("MyProfile")),
      body: new Container(),
    );
  }
}
