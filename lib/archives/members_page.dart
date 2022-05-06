import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/services/db.dart';
import 'package:travel_app/services/db_tasks.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/navigation.dart';


class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getFamilyRef(familyID, {flag = false}) {
    //   Map<String, dynamic> members = {};
    //   DatabaseReference familyRef;
    //   if (flag) {
    //     familyRef = FirebaseDatabase.instance.ref('families/$familyID/members');
    //   } else {
    //     familyRef = FirebaseDatabase.instance.ref('families/$familyID');
    //   }
    //   print(familyRef.get().then((value) {
    //     print('familyRef: ${value.value}');
    //     if (flag) {
    //       members = json.decode(value.value as String);
    //     }
    //   }));

    //   print(members);

    //   return familyRef;
    // }

    Widget content() {
      // DatabaseReference familyRef = getFamilyRef(familyID, flag: false);
      // familyRef = getFamilyRef(familyID, flag: true);

      return ChangeNotifierProvider<DB>(
        create: (ctx) => DB(uid: FirebaseAuth.instance.currentUser!.uid),
        child: Consumer<DB>(builder: (context, data, _) {
          return data.dataMembers.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data.dataMembers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data.dataMembers.keys.elementAt(index)),
                    );
                  },
                );
        }),
      );

      //  StreamBuilder<Map<String,dynamic>>(
      //     stream: FirebaseDatabase.instance
      //         .ref()
      //         .onValue,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator();
      //       }
      //       if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else if (snapshot.hasData ) {
      //         return ChangeNotifierProvider<DB>(
      //           create: (ctx) => DB(),
      //           child: Consumer<DB>(builder: (context, data, _) {
      //             return Container(
      //               color: Colors.green.withOpacity(0.2),
      //               height: 100,
      //             );
      //           }),
      //         );
      // DataSnapshot snap = (snapshot.data! as DatabaseEvent).snapshot;
      // //print(snap.value);
      // Map<dynamic, dynamic> members =
      //     snap.value as Map<dynamic, dynamic>;
      // return ListView.builder(
      //   itemCount: members.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(members.keys.elementAt(index)),
      //     );
      //   },
      // );
      //   } else
      //     return Center(child: CircularProgressIndicator());
      // });
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
