import 'dart:async';
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
            //            return CoinScreen(qrResult);
            return CoinScreenExample();
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
        child: ListView(
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
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(35.0),
        child: NiceButton(
          radius: 40,
          padding: const EdgeInsets.all(15),
          text: "Scan",
          icon: Icons.camera_alt,
          gradientColors: [Color(0xFFff4d00), Color(0xFFff9a00)],
          onPressed: _scanQR,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CoinScreen extends StatefulWidget {
  final String result;

  CoinScreen(this.result);

  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int measuredWeight = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("WE"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Text(
              "Teşekkürler kahraman!",
              style: TextStyle(color: kPrimaryColor, fontSize: 32),
            ),
          ),
          SizedBox(
              height: size.height * 0.4,
              width: size.width * 0.4,
              child: IconButton(
                icon: Image.asset("assets/we2.png"),
              )),
          Container(
            height: size.height * 0.2,
            width: size.width * 0.7,
            child: RaisedButton(
              child: Center(child: Text("Ödülünü almak için iki kez tıkla !")),
              color: kPrimaryColor,
              onPressed: () {
                setState(() {
                  fetchData(widget.result);
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Geri dönüştürdüğün miktar: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                measuredWeight.toString() + " g",
                style: TextStyle(color: kPrimaryColor, fontSize: 24),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Kazanılan coin: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                doubleWeight(measuredWeight).toString() + " WE Coin",
                style: TextStyle(color: kPrimaryColor, fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void fetchData(String result) async {
    await databaseReference.once().then((DataSnapshot snapshot) {
      measuredWeight = snapshot.value[result]["WEIGHT"];
    });
  }

  int doubleWeight(int number) {
    if (number != 0) {
      return number = number + number;
    }
    return number;
  }
}

//FloatingActionButton.extended(
//             backgroundColor: kPrimaryColor,
//             icon: Icon(Icons.camera_alt,size: 56,),
//             label: Center(child: Text("Scan",style: TextStyle(fontSize: 32),)),
//             onPressed: _scanQR,
//           ),
