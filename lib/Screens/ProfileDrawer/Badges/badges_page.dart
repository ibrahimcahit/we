import 'package:flutter/material.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Resources/components/pop_up.dart';

class BadgePage extends StatelessWidget {
  List<String> badges = [
    "2 of your friends must register with the code you gave them.",
    "You should share WE on a social media account which you want.",
    "You must contribute to development by sending 2 feedbacks.",
    "You must contribute to the transformation from Herostations at least 3 times for 3 weeks.",
    "You have to save the earth from 800 grams of non-recyclable plastic.",
    "15 of your friends should be part of We with the code defined for you.",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Badges",
            style: TextStyle(fontFamily: "Panthera", fontSize: 24),
          ),
        ),
        backgroundColor: kSecondaryColor,
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 2),
                PopUpButton(
                  text: badges[0],
                  widget: Image.asset(
                    "assets/Images/Badges/badge1.png",
                    scale: 0.9,
                  ),
                ),
                Column(
                  children: [
                    PopUpButton(
                      text: badges[1],
                      widget: Image.asset(
                        "assets/Images/Badges/badge2.png",
                        scale: 0.9,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 6,
                ),
                PopUpButton(
                  text: badges[2],
                  widget: Image.asset(
                    "assets/Images/Badges/badge3.png",
                    scale: 0.9,
                  ),
                ),
                PopUpButton(
                  text: badges[3],
                  widget: Image.asset(
                    "assets/Images/Badges/badge4.png",
                    scale: 0.9,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PopUpButton(
                  text: badges[4],
                  widget: Image.asset(
                    "assets/Images/Badges/badge5.png",
                    scale: 0.9,
                  ),
                ),
                PopUpButton(
                  text: badges[5],
                  widget: Image.asset(
                    "assets/Images/Badges/badge6.png",
                    scale: 0.9,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
