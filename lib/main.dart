import 'package:WE/Screens/Intro/welcome_screen.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/edit_profile.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/profile_page.dart';
import 'package:WE/Screens/onboarding_pages.dart';
import 'package:WE/deneme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Resources/SizeConfig.dart';
import 'Resources/constants.dart';
import 'Screens/BottomNavigation/bottom_navigation.dart';
import 'denem2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'WE',
              theme: ThemeData(
                canvasColor: kSecondaryColor,
                fontFamily: "Montserrat_Alternates",
                primaryColor: kPrimaryColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: WelcomeScreen(),
            );
          },
        );
      },
    );
  }
}
