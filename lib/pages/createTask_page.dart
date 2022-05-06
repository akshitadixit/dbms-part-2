// ignore_for_file: must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/widget/top_container.dart';
import 'package:travel_app/widget/back_button.dart';
import 'package:travel_app/widget/my_text_field.dart';
import 'package:travel_app/services/db.dart';

import '../services/db_tasks.dart';

class CreateNewTaskPage extends StatefulWidget {
  final familyID = '-N0iSxfUdSqT87v1zZw2';
  @override
  State<CreateNewTaskPage> createState() =>
      _CreateNewTaskPageState(familyID: this.familyID);
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  String title = '';
  String description = '';
  int timestamp = 0;

  Map memberMap = {
    'username': 'mum',
  }; // key: nick, value: uid

  final familyID;

  _CreateNewTaskPageState({required String this.familyID});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return ChangeNotifierProvider<DB>(
      create: (ctx) => DB(uid: FirebaseAuth.instance.currentUser!.uid),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopContainer(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                width: width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Create new task',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyTextField(
                              label: 'Title',
                              icon: Icon(
                                Icons.percent,
                                color: Color(0xFF).withOpacity(0),
                              ),
                              onchanged: (val) => {title = val},
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Consumer<DB>(builder: (context, data, _) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: MyTextField(
                              label: 'Deadline',
                              icon: downwardIcon,
                              onchanged: (val) => data.deadLineSelect(val),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Text('Assign To'),
                        SizedBox(width: 10),
                        Consumer<DB>(builder: (context, data, _) {
                          return data.dataMembers.isEmpty
                              ? CircularProgressIndicator()
                              : DropdownButton<String>(
                                  value: data.selectOneDropDown,
                                  items: data.dataMembers.keys
                                      .toList()
                                      .map((va) => DropdownMenuItem(
                                            child: Text(va),
                                            value: va,
                                          ))
                                      .toList(),
                                  onChanged: (ve) => data.selectOption(ve!),
                                );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: MyTextField(
                      label: 'Description',
                      minLines: 3,
                      maxLines: 3,
                      icon: Icon(
                        Icons.percent,
                        color: Color(0xFF).withOpacity(0),
                      ),
                      onchanged: (val) => {description = val},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            //direction: Axis.vertical,
                            alignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            runSpacing: 0,
                            //textDirection: TextDirection.rtl,
                            spacing: 10.0,
                            children: <Widget>[
                              Chip(
                                label: Text("SPORT APP"),
                                backgroundColor: Colors.redAccent,
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              Chip(
                                label: Text("MEDICAL APP"),
                              ),
                              Chip(
                                label: Text("RENT APP"),
                              ),
                              Chip(
                                label: Text("NOTES"),
                              ),
                              Chip(
                                label: Text("GAMING PLATFORM APP"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
              Container(
                height: 80,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Consumer<DB>(builder: (context, data, _) {
                        return ElevatedButton(
                          onPressed: () {
                            timestamp = DateTime.now().microsecondsSinceEpoch;
                            db.addTask(
                                title,
                                description,
                                data.selectOneDropDown,
                                timestamp,
                                data.deadline);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Create Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        );
                      }),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*

.
|- users
|    |- uid
|    |   |- mum
|    |   |- familyID
|    |   |- assigned
|    |   |     |- taskID
|
|- tasks
|    |- taskID
|    |   |- timestamp
|    |   |- deadline
|    |   |- title
|    |   |- description
|    |   |- assignedTo
|
|- families
|    |- familyID
|    |   |- head
|    |   |- members
|    |   |    |- uid
|    |   |    |- nick





*/
