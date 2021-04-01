import 'package:WE/Resources/components/opportunities/sliding_cards.dart';
import 'package:WE/Resources/components/opportunities/tabs.dart';
import 'package:flutter/material.dart';

class OpportunitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Opportunities",
          style: TextStyle(fontSize: 30, fontFamily: "Panthera"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25),
                Tabs(),
                SizedBox(height: 8),
                Cards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
