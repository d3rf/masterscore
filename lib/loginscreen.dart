import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget  {

  @override
  LoginScreenState createState() => new LoginScreenState();

}
class LoginScreenState extends State<LoginScreen>{
  String _login;
  String _password;
  GlobalKey<FormState> formLoginKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        //child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onSaved: (value)=> _login = value,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onSaved: (value)=> _password = value,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          formLoginKey.currentState.save();
          FirebaseAuth.instance.signInWithEmailAndPassword(email: _login, password: _password).then((user){
            print(user.uid);
          }).catchError((error)=> print(error.toString()));
          //Navigator.of(context).pushNamed(HomePage.tag);

        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formLoginKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel
            ],
          ),
        )
      ),
    );
  }
}