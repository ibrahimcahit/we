import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:WE/Screens/Intro/login_screen.dart';
import 'package:WE/Resources/components/or_divider.dart';
import 'package:WE/Resources/components/social_icon.dart';
import 'package:WE/Resources/components/already_have_an_account_acheck.dart';
import 'package:WE/Resources/components/rounded_button.dart';
import 'package:WE/Resources/components/rounded_input_field.dart';
import 'package:WE/Resources/components/rounded_password_field.dart';
import 'package:WE/Screens/BottomNavigation/bottom_navigation.dart';
import 'package:WE/Services/authentication.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _username, _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.1),
                  RoundedInputField(
                    hintText: "   Name",
                    onChanged: (value) {
                      setState(() {
                        _username = value.trim();
                      });
                    },
                  ),
                  RoundedInputField(
                    hintText: "   E-mail",
                    icon: Icons.mail,
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
                  RoundedInputField(
                    hintText: "   City",
                    icon: Icons.location_city_outlined,
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "   Your favourite super hero",
                    icon: Icons.local_fire_department_outlined,
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "SIGN UP",
                    press: () {
                      auth
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((_) {
                        signUp(_username, _email);
                        getUserData();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(
                    text: "OR",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        iconSrc: "assets/Icons/facebook64.png",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/Icons/twitter.png",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/Icons/google.png",
                        press: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
