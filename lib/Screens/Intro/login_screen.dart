import 'package:flutter/material.dart';
import 'package:WE/Screens/Intro/signup_screen.dart';
import 'package:WE/Resources/components/already_have_an_account_acheck.dart';
import 'package:WE/Resources/components/rounded_button.dart';
import 'package:WE/Resources/components/rounded_input_field.dart';
import 'package:WE/Resources/components/rounded_password_field.dart';
import 'package:WE/Resources/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:WE/Screens/BottomNavigation/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN IN",
                style: TextStyle(color: kPrimaryColor),
              ),
              Image.asset(
                "assets/we.png",
                scale: 2,
              ),
              RoundedInputField(
                hintText: "   E-mail",
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
              RoundedPasswordField(
                hintText: "Password",
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => BottomNavigation(),
                      ),
                      (route) => false,
                    );
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
