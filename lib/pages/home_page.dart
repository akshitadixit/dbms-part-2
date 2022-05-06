// ignore_for_file: must_be_immutable

import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/pages/calendar_page.dart';
import 'package:travel_app/pages/createTask_page.dart';
import 'package:travel_app/services/db2.dart';
import 'package:travel_app/services/db_tasks.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/active_project_card.dart';
import 'package:travel_app/widget/myTasks.dart';
import 'package:travel_app/widget/tab_family.dart';
import 'package:travel_app/widget/navigation.dart';
import 'package:travel_app/widget/task_column.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: Colors.lightGreenAccent,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List locationList = [];
  User? user = FirebaseAuth.instance.currentUser!;
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  Widget tasks() {
    return Column(
      children: [
        Container(
          height: 40.0,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateNewTaskPage(),
                ),
              );
            },
            child: Center(
              child: Text(
                'Add task',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            subheading('My Tasks'),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
              child: HomePage.calendarIcon(),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        TaskColumn(
          icon: Icons.alarm,
          iconBackgroundColor: Colors.redAccent,
          title: 'To Do',
          subtitle: '5 tasks now. 1 started',
        ),
        SizedBox(height: 15.0),
        TaskColumn(
          icon: Icons.blur_circular,
          iconBackgroundColor: Colors.yellow.shade700,
          title: 'In Progress',
          subtitle: '1 tasks now. 1 started',
        ),
        SizedBox(height: 15.0),
        TaskColumn(
          icon: Icons.check_circle_outline,
          iconBackgroundColor: Colors.lightBlue,
          title: 'Done',
          subtitle: '18 tasks now. 13 started',
        ),
      ],
    );
  }

  Widget activeTasks() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ChangeNotifierProvider<DB>(
        create: (ctx) => DB(uid: FirebaseAuth.instance.currentUser!.uid),
        child: Consumer<DB>(builder: (context, data, _) {
          print(data.tasks);
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              children: <Widget>[
                subheading('Active Projects'),
                SizedBox(height: 5.0),
                Column(
                  children: data.tasks.keys
                      .map(
                        (e) => Row(
                          children: <Widget>[
                            SizedBox(width: 20.0),
                            ActiveProjectsCard(
                              cardColor: Colors.redAccent,
                              loadingPercent: 0.6,
                              title: 'Making History Notes',
                              subtitle: '20 hours progress',
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Future<void> saveUserData(users) async {
  //   final uid = user;
  //   print(uid);
  //   await users.child(uid).set({
  //     'name': 'Plastic',
  //     'family': 'some family ref',
  //     'age': '20'
  //   }).then((onValue) {
  //     print('it says true');
  //   }).catchError((onError) {
  //     print('catch false');
  //   });
  //   print('return false');
  // }

  @override
  Widget build(BuildContext context) {
    Widget content() {
      Widget header() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 28),
              child: Row(
                children: [
                  Image.network(
                    user!.photoURL!,
                    width: 43.5,
                    height: 43.5,
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Text(
                        "Hello, ",
                        style: blackTextStyle,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName! ??
                            'Plastic',
                        style: blackTextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/icon_notification.png",
              width: 52,
            ),
          ],
        );
      }

      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 23,
            right: 23,
            top: 27,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              tasks(),
              //myTasks(),
              activeTasks(),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            content(),
            CustomNavigation(
              home: kOrangeColor,
              market: kdisableOrange,
              bookmarks: kdisableOrange,
              user: kdisableOrange,
            ),
          ],
        ),
      ),
    );
  }
}



/*


*/