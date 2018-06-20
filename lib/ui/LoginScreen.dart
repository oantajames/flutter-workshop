import 'package:flutter/material.dart';
import 'package:flutterworkshop/interactor/AuthenticationManager.dart';
import 'package:flutterworkshop/ui/FeedScreen.dart';
import 'package:logging/logging.dart';

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

  final Logger log = new Logger("_LoginScreenState");
  static final String LOGIN = "Login";
  static final String LOGING_IN = "Loging in...";
  static final String SUCCESS = "Succces";

  String _loginStatus = LOGIN;

  void _loginClicked() {
    setState(() {
      _loginStatus = LOGING_IN;
    });
    _authManager
        .login(_userNameController.text, _passwordController.text)
        .then((success) {
      if (success) {
        setState(() {
          _loginStatus = SUCCESS;
        });
        Navigator
            .of(context)
            .push(new MaterialPageRoute(builder: (context) => FeedScreen()));
      } else {
        setState(() {
          _loginStatus = LOGIN;
        });
        Navigator
            .of(context)
            .push(new MaterialPageRoute(builder: (context) => FeedScreen()));
        //todo - show error
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

    final email = Container(
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
              logoWithHeroAnimation,
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
