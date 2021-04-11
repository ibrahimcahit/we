import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestoreInstance = FirebaseFirestore.instance;
final uid = FirebaseAuth.instance.currentUser.uid;

void signUp(
    {String name,
    String password,
    String email,
    String city,
    String superhero,
    int level,
    double exp,
    int coins,
    int dailyCoins,
    int dailyRecycled,
    List<String> impact,
    String avatar,
    int recycled}) {
  firestoreInstance.collection("users").doc(uid).set({
    "name": name,
    "password": password,
    "email": email,
    "city": city,
    "exp": 0.1,
    "superhero": superhero,
    "level": 1,
    "coins": 0,
    "dailyCoins": 0,
    "dailyRecycled": 0,
    "recycled": 0,
    "avatar": null,
    "impact": ["Nothing", "2-hour bulb energy", "2 fish", "2kWh energy"]
  });
}

userData() {
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

final CollectionReference brewCollection =
    FirebaseFirestore.instance.collection('users');

Future<void> updateUserData({
  String city,
  String username,
  String password,
  String email,
  int level,
  int exp,
  int recycled,
  int dailyRecycled,
  String address,
  String avatar,
  String superhero,
}) async {
  return await brewCollection.doc(uid).update({
    'address': address,
    'name': username,
    'password': password,
    'avatar': avatar,
    'city': city,
    'email': email,
    'level': level,
    'exp': exp,
    'recycled': recycled,
    'dailyRecycled': dailyRecycled,
    'superhero': superhero,
  });
}
