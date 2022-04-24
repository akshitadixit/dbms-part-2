import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/navigation.dart';
import 'package:travel_app/widget/popular_card.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getFamilyID() {
      User? user = FirebaseAuth.instance.currentUser;
      String familyID = '';
      DatabaseReference familyRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user!.uid)
          .child('familyID');

      print(familyRef.get().then((value) {
        print('familyID: ${value.value}');
        familyID = value.value as String;
      }));
      return familyID;
    }

    getMembersRef(familyID) {
      DatabaseReference membersRef =
          FirebaseDatabase.instance.ref('members/$familyID');

      print(membersRef.get().then((value) {
        print('membersRef: ${value.value}');
        print('type:${value.value.runtimeType}');
      }));

      return membersRef.ref;
    }

    Widget content() {
      String familyID = getFamilyID();
      //List membersList = getFamilyMembers(familyID);
      DatabaseReference membersRef = getMembersRef(familyID);

      return StreamBuilder<Object>(
          stream: membersRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              DataSnapshot snap = (snapshot.data! as DatabaseEvent).snapshot;
              Map<dynamic, dynamic> values =
                  snap.value as Map<dynamic, dynamic>;
              print('values: $values');
              print('snap:${values.values.first.values.toList()}');
              List memberNames = values.values.first.keys.toList();
              List memberImages = values.values.first.values.toList();

              return ListView.builder(
                itemCount: memberNames.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PopularCard(
                          img: memberImages.elementAt(index),
                          username: memberNames.elementAt(index)),
                      SizedBox(height: 20),
                    ],
                  );
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            content(),
            CustomNavigation(
              home: kdisableOrange,
              market: kOrangeColor,
              bookmarks: kdisableOrange,
              user: kdisableOrange,
            ),
          ],
        ),
      ),
    );
  }
}
