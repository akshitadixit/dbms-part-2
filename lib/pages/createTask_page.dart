// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  int deadline = 0;
  late var assignedTo = '';
  Map memberMap = {
    'username': 'mum',
  }; // key: nick, value: uid

  final familyID;

  _CreateNewTaskPageState({required String this.familyID});

  Widget DropDownButton(
      {List<DropdownMenuItem<String>>? items,
      Null Function(Object? selected)? onChanged,
      String? value,
      MaterialColor? iconEnabledColor,
      MaterialColor? iconDisabledColor,
      int? iconSize}) {
    return ChangeNotifierProvider<DB>(
      create: (ctx) => DB(uid: FirebaseAuth.instance.currentUser!.uid),
      child: Consumer<DB>(builder: (context, data, _) {
        return data.dataMembers.isEmpty
            ? CircularProgressIndicator()
            : DropDownButton(
                items: data.dataMembers.keys
                    .toList()
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (Object? selected) {
                  print(selected);
                  setState(() {
                    this.assignedTo = selected! as String;
                  });
                },
                value:
                    assignedTo == '' ? assignedTo : data.dataMembers.keys.first,
                iconEnabledColor: Colors.lightBlue,
                iconDisabledColor: Colors.lightGreen,
                iconSize: 40,
              );
      }),
    );
  }

  Widget DropDown() {
    return DropdownButton(
      items: this
          .memberMap
          .keys
          .toList()
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (Object? selected) {
        print(selected);
        setState(() {
          this.assignedTo = selected! as String;
        });
      },
      value: assignedTo,
      iconEnabledColor: Colors.lightBlue,
      iconDisabledColor: Colors.lightGreen,
      iconSize: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              height: width * 0.6,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
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
                  SizedBox(height: 20),
                  Container(
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
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: MyTextField(
                          label: 'Deadline',
                          icon: downwardIcon,
                          onchanged: (val) => {
                            deadline = DateTime(DateTime.now().add(Duration(
                                    hours: val.split(':')[0],
                                    minutes: val.split(':')[1])) as int)
                                .microsecondsSinceEpoch
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Assign To'),
                      SizedBox(width: 10),
                      DropDownButton(),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Description',
                    minLines: 3,
                    maxLines: 3,
                    icon: Icon(
                      Icons.percent,
                      color: Color(0xFF).withOpacity(0),
                    ),
                    onchanged: (val) => {description = val},
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
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
                  )
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        timestamp = DateTime.now().microsecondsSinceEpoch;
                        db.addTask(title, description, assignedTo, timestamp,
                            deadline);
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
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
