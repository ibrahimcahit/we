import 'dart:async';
import 'package:WE/Resources/components/or_divider.dart';
import 'package:WE/Screens/BottomNavigation/QR/pin_code.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:WE/Resources/constants.dart';
import 'package:nice_button/nice_button.dart';
import 'package:WE/Screens/BottomNavigation/QR/instructions.dart';
import 'package:WE/Screens/BottomNavigation/QR/coin_screen.dart';

var instructions = [
  "Products must be plastic and suitable for recycling.",
  "The inside of the products should be completely empty in terms of liquid, etc.",
  "Read the QR code above HeroStation from your device.",
  "Hey\! be sure to close the cover on HeroStation to be ready for new heroes."
];

class QRScanPage extends StatefulWidget {
  @override
  QRScanPageState createState() {
    return QRScanPageState();
  }
}

class QRScanPageState extends State<QRScanPage> {
  static String result;

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            //            return CoinScreenExample(qrResult);
            return CoinScreenExample(qrResult: qrResult);
          },
        ),
      );
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR",
          style: TextStyle(fontFamily: "Panthera", fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "We're glad to see you here. There's a list we'd like you to review before you start.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              "Instructions",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(height: size.height * 0.02),
            Column(children: [
              CarouselSlider(
                items: instructionItems,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: instructions.map((url) {
                  int index = instructions.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _current == index ? kPrimaryColor : Colors.white),
                  );
                }).toList(),
              ),
            ]),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NiceButton(
                    width: 150,
                    radius: 10,
                    text: "Scan",
                    icon: Icons.qr_code_rounded,
                    gradientColors: [Color(0xFFff4d00), Color(0xFFff9a00)],
                    onPressed: _scanQR,
                    background: kSecondaryColor,
                  ),
                  NiceButton(
                    width: 150,
                    radius: 10,
                    text: "Enter",
                    icon: Icons.add_to_home_screen_rounded,
                    gradientColors: [Color(0xFFff4d00), Color(0xFFff9a00)],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PinCodeVerificationScreen();
                          },
                        ),
                      );
                    },
                    background: kSecondaryColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
