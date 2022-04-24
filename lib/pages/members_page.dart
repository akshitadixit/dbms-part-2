import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/navigation.dart';

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

    getFamilyRef(familyID, {flag = false}) {
      Map<String, dynamic> members = {};
      DatabaseReference familyRef;
      if (flag) {
        familyRef = FirebaseDatabase.instance.ref('families/$familyID/members');
      } else {
        familyRef = FirebaseDatabase.instance.ref('families/$familyID');
      }
      print(familyRef.get().then((value) {
        print('familyRef: ${value.value}');
        if (flag) {
          members = json.decode(value.value as String);
        }
      }));

      print(members);

      return familyRef;
    }

    Widget content() {
      String familyID = getFamilyID();
      DatabaseReference familyRef = getFamilyRef(familyID, flag: false);
      familyRef = getFamilyRef(familyID, flag: true);

      return StreamBuilder<Object>(
          stream: familyRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              DataSnapshot snap = (snapshot.data! as DatabaseEvent).snapshot;
              //print(snap.value);
              Map<dynamic, dynamic> members =
                  snap.value as Map<dynamic, dynamic>;
              return ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(members.keys.elementAt(index)),
                  );
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          });
    }

    Widget body() {
      return Container();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            content() as Widget,
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
