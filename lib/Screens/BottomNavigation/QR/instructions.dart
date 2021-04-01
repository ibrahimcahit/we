import 'package:flutter/material.dart';
import 'package:WE/Resources/constants.dart';

var instructions = [
  "Products must be plastic and suitable for recycling.",
  "The inside of the products should be completely empty in terms of liquid, etc.",
  "Read the QR code above HeroStation from your device.",
  "Hey\! be sure to close the cover on HeroStation to be ready for new heroes."
];

var instructionTitles = [
  "Suitable for recycling",
  "Completely empty",
  "Read the QR code",
  "Close the cover"
];

final List<Widget> instructionItems = instructions
    .map((item) => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(item,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kPrimaryColor, kPrimaryColorOld],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Center(
                            child: Text(
                              instructionTitles[instructions.indexOf(item)],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ))
    .toList();
