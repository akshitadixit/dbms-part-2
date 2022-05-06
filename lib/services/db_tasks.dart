import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DB extends ChangeNotifier {
  final String uid;
  String familyID = '';
  static final DatabaseReference database = FirebaseDatabase.instance.ref();

  final _ref = FirebaseDatabase.instance;

  Map<String, dynamic> dataMembers = {};
  Map<String, dynamic> tasks = {};

  String selectOneDropDown = 'test-mum-1';
  int deadline = 0;
  void deadLineSelect(String val) {
    deadline = DateTime(DateTime.now().add(Duration(
            hours: int.parse(val.split(':')[0]),
            minutes: int.parse(val.split(':')[1]))) as int)
        .microsecondsSinceEpoch;
    notifyListeners();
  }

  void selectOption(String value) {
    selectOneDropDown = value;
    notifyListeners();
  }

  DB({required this.uid}) {
    _registerFamilyID();
  }

  void _registerFamilyID() async {
    final DataSnapshot va = await _ref.ref('users/$uid/familyID').get();
    familyID = va.value.toString();
    _runTest();
    _runTask();
    notifyListeners();
  }

  late StreamSubscription _data;

  void _runTest() {
    _data = _ref.ref('families/$familyID/members').onValue.listen((event) {
      dataMembers = event.snapshot.value as Map<String, dynamic>;
      notifyListeners();
    });
  }

  void _runTask() {
    _ref.ref('tracks').onValue.listen((event) {
      print(event.toString());
      tasks = event.snapshot.value as Map<String, dynamic>;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _data.cancel();
    super.dispose();
  }
}
