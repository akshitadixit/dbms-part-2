// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widget/top_container.dart';
import 'package:travel_app/widget/back_button.dart';
import 'package:travel_app/widget/my_text_field.dart';
import 'package:travel_app/services/db.dart';

class CreateNewTaskPage extends StatefulWidget {
  final familyID = 'family1';
  @override
  State<CreateNewTaskPage> createState() =>
      _CreateNewTaskPageState(familyID: this.familyID);
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  String title = '';
  String description = '';
  int timestamp = 0;
  int deadline = 0;
  late var assignedTo;
  late Map memberMap; // key: nick, value: uid

  final familyID;

  _CreateNewTaskPageState({required String this.familyID});

  initState() {
    getFamilyMembers();
    super.initState();
  }

  getFamilyMembers() async {
    // get members from firebase
    DatabaseReference membersRef =
        FirebaseDatabase.instance.ref().child('families/$familyID/members');

    final event = await membersRef.once(DatabaseEventType.value);
    setState(() {
      this.memberMap = event.snapshot.value as Map<dynamic, dynamic>;
      if (this.assignedTo == null) {
        this.assignedTo = this.memberMap.keys.first;
      }
    });
    print(this.memberMap);
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
          this.assignedTo = selected;
        });
      },
      value: assignedTo,
      iconEnabledColor: Colors.lightBlue,
      iconDisabledColor: Colors.lightGreen,
      iconSize: 40,
    );
  }

  // Future<void> createTask() async {
  //   final DatabaseReference tasks = FirebaseDatabase.instance.ref('tasks');
  //   var taskref = tasks.push();
  //   await taskref.set({
  //     'title': title,
  //     'description': description,
  //     'assignedTo': assignedTo,
  //     'timestamp': timestamp,
  //     'deadline': deadline,
  //   }).then((onValue) {
  //     print('task created');
  //   }).catchError((onError) {
  //     print('error1');
  //   });

  //   print(taskref);
  //   print(assignedTo);

  //   // add taskID in under the user

  //   var newRef = FirebaseDatabase.instance.ref('users/${assignedTo}/assigned');
  //   await newRef.push().set(taskref.key).then((onValue) {
  //     print('task added to user');
  //   }).catchError((onError) {
  //     print('error2');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    getFamilyMembers();
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
                            deadline = DateTime(DateTime.now()
                                        .add(Duration(hours: val.split(':')[0]))
                                    as int)
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
                      DropDown(),
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
