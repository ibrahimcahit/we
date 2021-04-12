import 'package:WE/Screens/BottomNavigation/Leaderboard/leaderboard.dart';
import 'package:WE/Screens/BottomNavigation/Offers/offers.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:WE/Screens/BottomNavigation/Map/map_view.dart';
import 'package:WE/Screens/BottomNavigation/QR/qr_page.dart';
import 'package:WE/Screens/ProfileDrawer/profile_drawer.dart';
import '../../Resources/constants.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;
  final _pageOptions = [
    ProfileDrawer(),
    MapView(),
    QRScanPage(),
    Offer(),
    Leaderboard()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _pageOptions[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(
                icon:
                    Image.asset("assets/Images/BottomNavigation/homeIcon.png")),
            TabItem(
                icon: Image.asset(
              "assets/Images/BottomNavigation/mapIcon.png",
              color: kThirdColor,
            )),
            TabItem(
                icon: Image.asset("assets/Images/BottomNavigation/qrIcon.png",
                    color: kThirdColor)),
            TabItem(
                icon: Image.asset(
              "assets/Images/BottomNavigation/privilege.png",
              color: kThirdColor,
            )),
            TabItem(
                icon: Image.asset(
              "assets/Images/BottomNavigation/leaderboardIcon.png",
              color: kThirdColor,
            )),
          ],
          activeColor: kPrimaryColor,
          backgroundColor: kPrimaryColor,
          initialActiveIndex: 0,
          onTap: (int i) {
            setState(() {
              selectedPage = i;
            });
          },
        ),
      ),
    );
  }
}
