import 'package:WE/Screens/BottomNavigation/Feed/feed_screen.dart';
import 'package:WE/Screens/ProfileDrawer/Badges/badges_page.dart';
import 'package:WE/Screens/ProfileDrawer/Challenges/challenge_page.dart';
import 'package:WE/Screens/ProfileDrawer/Help/contact_page.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/profile_page.dart';
import 'package:WE/Screens/ProfileDrawer/Feedback/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Services/ChatService/chat_screen.dart';
import 'Entertainment/entertainment_page.dart';
import '../../Services/profile_search.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem({
    this.title,
    this.icon,
  }) : assert(icon is IconData || icon is Widget,
            'TabItem only support IconData and Widget');
}

class ProfileDrawer extends StatefulWidget {
  final drawerItems = [
    DrawerItem(title: "Profile", icon: Icons.person_rounded),
    DrawerItem(title: "Challenge", icon: Icons.whatshot),
    DrawerItem(title: "Badges", icon: Icons.badge),
    DrawerItem(title: "Did you know these?", icon: Icons.wb_incandescent),
    DrawerItem(title: "Feedback", icon: Icons.assistant_photo_rounded),
    DrawerItem(title: "Support", icon: Icons.help),
    DrawerItem(title: "Home", icon: Icons.help),
  ];
  final drawerTitles = [
    DrawerItem(title: "Profile Page", icon: Icons.person_rounded),
    DrawerItem(title: "Challenges", icon: Icons.whatshot),
    DrawerItem(title: "Badges", icon: Icons.badge),
    DrawerItem(title: "Entertainment", icon: Icons.wb_incandescent),
    DrawerItem(title: "Feedback", icon: Icons.assistant_photo_rounded),
    DrawerItem(title: "Support", icon: Icons.help),
    DrawerItem(title: "Home", icon: Icons.help),
  ];

  @override
  State<StatefulWidget> createState() {
    return ProfileDrawerState();
  }
}

class ProfileDrawerState extends State<ProfileDrawer> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return FeedScreen();
      case 1:
        return ProfilePage();
      case 2:
        return ChallengePage();
      case 3:
        return BadgePage();
      case 4:
        return EntertainmentPage();
      case 5:
        return FeedbackPage();
      case 6:
        return SupportPage();

      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    // setState(() => _selectedDrawerIndex = index);

    // Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => _getDrawerItemWidget(index)));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length - 1; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(
          d.icon,
          color: kPrimaryColor,
        ),
        title: Text(
          d.title,
          style: TextStyle(color: kThirdColor),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i + 1),
      ));
    }
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Container(
                width: 30,
                child: Image.asset(
                  "assets/Icons/send.png",
                  color: Colors.white,
                )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage();
                  },
                ),
              );
            },
          )
        ],
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "WE",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: 'Panthera'),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: kPrimaryColor),
              accountName: Text(
                "Superman",
                style: TextStyle(color: kThirdColor),
              ),
              accountEmail: Text(
                "Alihan Soykal",
                style: TextStyle(color: kThirdColor),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: kThirdColor,
                child: Image.asset("assets/Images/People/alihan.png"),
              ),
            ),
            Column(children: drawerOptions),
          ],
        ),
      ),
    );
  }
}
