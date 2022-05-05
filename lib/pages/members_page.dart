import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/navigation.dart';
import 'package:travel_app/widget/popular_card.dart';

import '../services/db2.dart';

class MembersPage extends StatefulWidget {
  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late var familyID;
  late DatabaseReference membersRef;
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  initState() {
    this.database.child('users/${user!.uid}/familyID').once().then((snapshot) {
      this.familyID = snapshot.snapshot.value;
      this.membersRef = this.database.child('families/$familyID/members');
      print('familyID: $familyID, membersRef: $membersRef');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content() {
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

  // getFamilyMembers() async {
  //   // get members from firebase
  //   DatabaseReference membersRef =
  //       FirebaseDatabase.instance.ref().child('families/$familyID/members');

  //   membersRef.once().then((DatabaseEvent event) {
  //     setState(() {
  //       this.memberMap = event.snapshot.value as Map<dynamic, dynamic>;
  //       if (this.assignedTo == 'mum') {
  //         this.assignedTo = this.memberMap.keys.first;
  //       }
  //     });
  //   });
  //   print(this.memberMap);
  // }