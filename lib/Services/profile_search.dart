import 'package:flutter/material.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/user_profile.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();
  List<String> users = [
    'Aysu Keçeci',
    "Larry Page",
    'Safra Catz',
    'Sundar Pichai',
    'Elon Musk',
    "Oprah Winfrey",
    'Jeff Bezos',
    "Bill Gates",
    'Mary Barra',
    'Larry Ellison',
    'Mark Zuckerberg'
  ];
  List<String> subtitles = [
    'Wonder woman',
    "X-man",
    'Catwoman',
    'Superman',
    'Captain America',
    "Wonder woman",
    'Ironman',
    'Captain America',
    'Wonder woman',
    "Superman",
    'Superman',
    'Ironman',
  ];
  final images = [
    "assets/Images/People/aysu.png",
    "assets/Images/People/larryPage.png",
    "assets/Images/People/safraCatz.png",
    "assets/Images/People/sundarPichai.png",
    "assets/Images/People/elonMusk.png",
    "assets/Images/People/oprah.png",
    "assets/Images/People/jeffBezos.png",
    "assets/Images/People/billGates.png",
    "assets/Images/People/maryBarra.png",
    "assets/Images/People/larryEllison.png",
    "assets/Images/People/markZuckerberg.png",
  ];

  var items = List<String>();

  @override
  void initState() {
    items.addAll(users);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(users);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(users);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Search",
          style: TextStyle(fontFamily: "Panthera", fontSize: 24),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    hoverColor: kPrimaryColor,
                    focusColor: kPrimaryColor,
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search, color: kPrimaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.only(left: 15, top: 5),
                    leading: Image.asset(images[index]),
                    title: Text(
                      '${items[index]}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    subtitle: Text(subtitles[index]),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
