import 'package:WE/Resources/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:WE/Services/authentication.dart';

class DenemePage2 extends StatefulWidget {
  @override
  _DenemePage2State createState() => _DenemePage2State();
}

class _DenemePage2State extends State<DenemePage2> {
  String _address, _email, _password;
  String city;
  String measuredWeight = "";

  @override
  void initState() {
    super.initState();
    getData();
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    // <1> Use FutureBuilder
    return Scaffold();
  }
}

class GetUserName extends StatelessWidget {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(firebaseUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['city']} ${data['city']}");
        }
        return Text("loading");
      },
    );
  }
}

getData() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  await firestoreInstance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    var city = value.data()['city'];
    print("xxxxxxx");
    print(city);
  });
}
