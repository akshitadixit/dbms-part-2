import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DB extends ChangeNotifier {
  final String uid;
  String familyID = '';
  static final DatabaseReference database = FirebaseDatabase.instance.ref();

  final _ref = FirebaseDatabase.instance;

  Map<String, dynamic> dataMembers = {};

  DB({required this.uid}) {
    _registerFamilyID();
  }

  void _registerFamilyID() async {
    final DataSnapshot va = await _ref.ref('users/$uid/familyID').get();
    familyID = va.value.toString();
    _runTest();
    notifyListeners();
  }

  late StreamSubscription _data;

  void _runTest() {
    _data = _ref.ref('families/$familyID/members').onValue.listen((event) {
      dataMembers = event.snapshot.value as Map<String, dynamic>;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _data.cancel();
    super.dispose();
  }
}
