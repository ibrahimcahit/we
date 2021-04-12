import 'package:WE/Screens/BottomNavigation/bottom_navigation.dart';
import 'package:WE/Screens/Intro/onboarding_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Resources/SizeConfig.dart';
import 'Resources/constants.dart';

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
              home: FirstScreen(),
            );
          },
        );
      },
    );
  }
}
