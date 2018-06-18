import 'package:flutter/material.dart';
import 'package:flutterworkshop/interactor/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/FeedScreen.dart';

class LoginScreen extends StatefulWidget {
  static Color colorBlue = const Color(0xFF3662FD);
  static String tag = 'login-screen';

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationManager _authManager = new AuthenticationManager();
  final _userNameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  void _loginClicked() {
    _authManager
        .login(_userNameController.text, _passwordController.text)
        .then((success) {
      if (success) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => FeedScreen()));
      } else {
        //todo - show error message
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

    final logo = AnimatedOpacity(
      opacity: 1.0,
      duration: new Duration(milliseconds: 1000),
      child: new Container(
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
      ),
    );

    final email = Container(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(color: Colors.white),
            autofocus: true,
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
            "Log In",
            style: TextStyle(color: LoginScreen.colorBlue),
          ),
        ),
      ),
    );

    final validationForm = new Form(
      key: null,
      child: Column(
        children: <Widget>[email, password],
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
