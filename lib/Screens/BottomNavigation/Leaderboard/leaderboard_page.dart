import 'package:flutter/material.dart';
import 'package:WE/Resources/SizeConfig.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/user_profile.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Leaderboard",
          style: TextStyle(fontFamily: "Panthera", fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HerProfile();
                  },
                ),
              );
            },
            trailing: Container(
              height: 7 * SizeConfig.heightMultiplier,
              width: 12 * SizeConfig.widthMultiplier,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(leaderboardIcons[index]))),
            ),
            leading: Container(
              height: 7 * SizeConfig.heightMultiplier,
              width: 12 * SizeConfig.widthMultiplier,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(images[index]))),
            ),
            title: Text(titles[index]),
          ));
        },
      ),
    );
  }
}

final titles = [
  "Larry Page",
  'Safra Catz',
  'Alihan Soykal',
  'Sundar Pichai',
  'Aysu Keçeci',
  'Elon Musk',
  "Oprah Winfrey",
  'Jeff Bezos',
  "Bill Gates",
  'Mary Barra',
  'Larry Ellison',
  'Mark Zuckerberg'
];
final leaderboardIcons = [
  "assets/Icons/gold-cup.png",
  "assets/Icons/silver-cup.png",
  "assets/Icons/bronze-cup.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png",
  "assets/Icons/badge.png"
];
final images = [
  "assets/Images/People/larryPage.png",
  "assets/Images/People/safraCatz.png",
  "assets/Images/People/alihan.png",
  "assets/Images/People/sundarPichai.png",
  "assets/Images/People/aysu.png",
  "assets/Images/People/elonMusk.png",
  "assets/Images/People/oprah.png",
  "assets/Images/People/jeffBezos.png",
  "assets/Images/People/billGates.png",
  "assets/Images/People/maryBarra.png",
  "assets/Images/People/larryEllison.png",
  "assets/Images/People/markZuckerberg.png",
];
