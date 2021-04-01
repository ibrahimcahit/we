import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestoreInstance = FirebaseFirestore.instance;

void signUp(String username, String email) {
  final uid = FirebaseAuth.instance.currentUser.uid;
  firestoreInstance.collection("users").doc(uid).set({
    "name": username,
    "age": 50,
    "email": email,
    "address": {"street": "street 24", "city": "new york"}
  });
}

getUserData() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("users")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    print(value.data()["name"]);
    var username = value.data()["name"];
    return username;
  });
}
