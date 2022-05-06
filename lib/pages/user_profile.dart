// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/services/auth.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/navigation.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    User? user = FirebaseAuth.instance.currentUser;
    Widget ScrollContent() {
      Widget UserLiked() {
        return Container(
          margin: EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Account Settings",
                          style: blackTextStyle.copyWith(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          await _auth.signout();
                          // print("logged out");
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/boarding',
                            (route) => false,
                          );
                        },
                        child: Icon(
                          Icons.logout_rounded,
                          size: 24.0,
                        )),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL.toString()),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                user.displayName.toString().substring(0, 1).toUpperCase() +
                    user.displayName.toString().substring(1),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      }

      // Widget userCard() {
      //   return StreamBuilder(
      //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
      //     builder:
      //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (!snapshot.hasData)
      //         return const Center(child: CircularProgressIndicator());

      //       return Container(
      //         margin: EdgeInsets.only(top: 20),
      //         child: Column(
      //           children: [
      //             Container(
      //               margin: EdgeInsets.symmetric(
      //                 horizontal: 20.0,
      //               ),
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                     color: Colors.grey,
      //                     width: 1.0,
      //                     style: BorderStyle.solid),
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(10.0),
      //                   topRight: Radius.circular(10.0),
      //                   bottomLeft: Radius.circular(10.0),
      //                   bottomRight: Radius.circular(10.0),
      //                 ), //Border.all
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: kGreyColor,
      //                     offset: const Offset(
      //                       5.0,
      //                       6.0,
      //                     ),
      //                     blurRadius: 10.0,
      //                     spreadRadius: 2.0,
      //                   ),
      //                   BoxShadow(
      //                     color: Colors.white,
      //                     offset: const Offset(0.0, 0.0),
      //                     blurRadius: 0.0,
      //                     spreadRadius: 0.0,
      //                   ), //BoxShadow
      //                 ],
      //               ),
      //               child: Column(children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 8.0),
      //                   child: Image.asset(
      //                     "assets/image_header_detail.png",
      //                     width: 300.0,
      //                     height: 300.0,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(10.0),
      //                   width: double.infinity,
      //                   child: Column(children: [
      //                     Text(
      //                       user,
      //                       style: const TextStyle(
      //                         fontSize: 25.0,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                       textAlign: TextAlign.center,
      //                     ),
      //                     SizedBox(height: 20),
      //                     Container(
      //                       width: double.infinity,
      //                       padding: EdgeInsets.fromLTRB(130, 0, 0, 0),
      //                       child: Row(
      //                         children: [
      //                           Icon(Icons.location_pin, color: kOrangeColor),
      //                           Text(
      //                             "India",
      //                             style: const TextStyle(
      //                               fontSize: 15.0,
      //                               color: Colors.grey,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     SizedBox(height: 7),
      //                     Container(
      //                       width: double.infinity,
      //                       padding: EdgeInsets.fromLTRB(93, 0, 0, 0),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.phone,
      //                             color: kOrangeColor,
      //                           ),
      //                           Text(
      //                             '',
      //                             style: const TextStyle(
      //                               fontSize: 15.0,
      //                               color: Colors.grey,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     SizedBox(height: 7),
      //                     Container(
      //                       width: double.infinity,
      //                       padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.mail_sharp,
      //                             color: kOrangeColor,
      //                           ),
      //                           Text(
      //                             " name@example.com",
      //                             style: const TextStyle(
      //                               fontSize: 15.0,
      //                               color: Colors.grey,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     SizedBox(height: 7),
      //                   ]),
      //                   // ]),
      //                 )
      //               ]),
      //             ),
      //             SizedBox(height: 30.0),
      //             // SizedBox(height: 20.0),
      //           ],
      //         ),
      //       );
      //     },
      //   );
      // }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserLiked(),
            //userCard(),
            SizedBox(height: 20.0),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            ScrollContent(),
            CustomNavigation(
              home: kdisableOrange,
              market: kdisableOrange,
              bookmarks: kdisableOrange,
              user: kOrangeColor,
            ),
          ],
        ),
      ),
    );
  }
}
