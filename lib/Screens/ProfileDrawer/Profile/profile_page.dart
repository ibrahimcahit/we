import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Resources/SizeConfig.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: TextStyle(fontFamily: "Panthera", fontSize: 24),
        ),
      ),
      backgroundColor: kSecondaryColor,
      body: Column(
        children: <Widget>[
          Container(
            color: kSecondaryColor,
            height: 30 * SizeConfig.heightMultiplier,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 4 * SizeConfig.heightMultiplier),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 11 * SizeConfig.heightMultiplier,
                        width: 22 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/Images/People/alihan.png"))),
                      ),
                      SizedBox(
                        width: 6 * SizeConfig.widthMultiplier,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Alihan Soykal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/Icons/supermanicon.png",
                                scale: 0.2,
                                color: Colors.white,
                                height: 3 * SizeConfig.heightMultiplier,
                                width: 3 * SizeConfig.widthMultiplier,
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text(
                                "Superman",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 1.5 * SizeConfig.textMultiplier,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "10.2K",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total coin",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "543 g",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "All-time recycled",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "EDIT PROFILE",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 1.8 * SizeConfig.textMultiplier),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.5, 0.5),
            child: Container(
                color: kSecondaryColor,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                height: 300,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 11),
                            child: SizedBox(
                                height: 200,
                                width: 200,
                                child: LiquidCircularProgressIndicator(
                                  value: 0.5,
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.lightBlue[200]),
                                  backgroundColor: Colors.white,
                                  borderColor: kPrimaryColor,
                                  borderWidth: 5.0,
                                  direction: Axis.vertical,
                                  center: Text("Level 9 "), //text inside it
                                ))),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Recycled",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "today:",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "402 g",
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Text(
                                "Coin earned",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "today:",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "5200 WE Coin",
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Your impact:",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "2-hour bulb energy",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 13.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
