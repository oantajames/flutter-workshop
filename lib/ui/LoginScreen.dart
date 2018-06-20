import 'package:flutter/material.dart';
import 'package:flutterworkshop/networking/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/FeedScreen.dart';

class LoginScreen extends StatefulWidget {
  static Color colorBlue = const Color(0xFF3662FD);
  static String tag = 'login-screen';

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationManager _authManager = new AuthenticationManager();

  //todo 1 - create TexEditingController for the userName and password and pass them to the widgets.

  //todo 3: Update the text from the login button as follows: (hint - use setState)
  // todo: Default saying: Login
  //todo: When Clicked: Logging in...
  //todo: On Success: Success
  //todo: On error/failed: Login

  String _loginStatus = "Login";

  void _loginClicked() {
    //todo 2: pass the username and password from the TexEditingController here
    _authManager.login("", "").then((success) {
      if (success) {
        Navigator
            .of(context)
            .push(new MaterialPageRoute(builder: (context) => FeedScreen()));
      } else {
        //todo 3:- show a SnackBar with an error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _authManager.init();

    InputDecoration _createDecorationInput(String hint) {
      return new InputDecoration(
          hintText: hint,
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: new BorderSide(color: Colors.white)));
    }

    //todo 6: - wrap the container inside a Hero widget and set the tag of the widget to githubLogo
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

    final username = Container(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(color: Colors.white),
            autofocus: false,
            decoration: _createDecorationInput("Email")));

    final password = Container(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          obscureText: true,
          autofocus: false,
          style: new TextStyle(color: Colors.white),
          decoration: _createDecorationInput("Password"),
        ));

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.blue.shade100,
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () => _loginClicked(),
          color: Colors.white,
          child: Text(
            _loginStatus,
            style: TextStyle(color: LoginScreen.colorBlue),
          ),
        ),
      ),
    );

    final validationForm = new Form(
      key: null,
      child: Column(
        children: <Widget>[username, password],
      ),
    );

    return new Scaffold(
      backgroundColor: LoginScreen.colorBlue,
      body: new Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              validationForm,
              loginButton,
              new SizedBox(
                height: 100.0,
              )
            ]),
      ),
    );
  }
}
