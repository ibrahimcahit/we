import 'package:WE/Resources/constants.dart';
import 'package:WE/Screens/Intro/welcome_screen.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class FirstScreen extends StatefulWidget {
  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen>
    with AfterLayoutMixin<FirstScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingPage()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("isFirstOpen", "false");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildImage(String assetName, {double scale, double width = 350}) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      scale: scale,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);

    const pageDecoration = PageDecoration(
      contentPadding: EdgeInsets.only(top: 50),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kSecondaryColor,
      imagePadding: EdgeInsets.only(top: 50),
    );
    const initialPageDecoration = PageDecoration(
      contentPadding: EdgeInsets.only(top: 50),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kSecondaryColor,
      imagePadding: EdgeInsets.only(top: 50),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kSecondaryColor,
      pages: [
        PageViewModel(
          titleWidget: RichText(
            text: TextSpan(
                text: "Convenient",
                children: [
                  TextSpan(
                      text: " and",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  TextSpan(
                    text: " Gamified",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                      text: " Recycling",
                      style: TextStyle(
                        color: Color(0xFF8CC8EE),
                        fontWeight: FontWeight.bold,
                      )),
                ],
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            textAlign: TextAlign.center,
          ),
          body: "Let's transform the plastic recycling of today!",
          image: _buildImage('we2.png', scale: 1.2),
          decoration: initialPageDecoration,
        ),
        PageViewModel(
          title: "Recycle Plastic Waste",
          body:
              "You can recycle your plastic waste using the QR code or code at the top of the HeroStations.",
          image: _buildImage('Images/Onboarding/intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track the Impact",
          body: "You can track your positive effects on environment.",
          image: _buildImage('Images/Onboarding/intro2.png', scale: 0.4),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get the Reward",
          body: "You can enjoy opportunities and privileges.",
          image: _buildImage('Images/Onboarding/intro3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
            title: "Follow Friends",
            body: "You can track your friends' in app recycling movements.",
            image: _buildImage('Images/Onboarding/intro4.png'),
            decoration: pageDecoration),
        PageViewModel(
            title: "Have Fun!",
            image: _buildImage('Images/Onboarding/intro5.png'),
            bodyWidget: Wrap(children: [
              Text(
                  "You can complete challenges to earn more badges and WE coins or duel with other people for fun.",
                  textAlign: TextAlign.center,
                  style: bodyStyle)
            ]),
            decoration: pageDecoration),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: const DotsDecorator(
        activeColor: kPrimaryColor,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
