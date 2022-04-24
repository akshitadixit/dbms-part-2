import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

/*

- mom sign up
- mom give familyID to kids
- kids sign up
- mom add new task
- generate task list

*/

class db {
  static final DatabaseReference database = FirebaseDatabase.instance.ref();

  static addUser() {
    User? user = FirebaseAuth.instance.currentUser;

    DatabaseReference familyref = database.child('families').push();
    database.child('users').child(user!.uid).set({
      'username': user.displayName,
      'familyID': familyref.key,
    });

    familyref.set({
      'head': user.uid,
      'members': {
        user.displayName: user.uid,
      },
    });
  }

  // let mum share her familyID with members
  static addUserbyCode(String code) {
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference familyref = database.child('families/$code/members');

    database.child('users').child(user!.uid).set({
      'username': user.displayName,
      'familyID': code,
    });

    familyref.child(user.displayName!).set(user.uid);
  }

  static addTask(String title, String description, String assignedTo,
      int timestamp, int deadline) {
    DatabaseReference tasks = database.child('tasks');
    var taskref = tasks.push();
    taskref.set({
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'timestamp': timestamp,
      'deadline': deadline,
    }).then((onValue) {
      print('task created');
    }).catchError((onError) {
      print('error1');
    });

    print(taskref);
    print(assignedTo);

    // add taskID in under the user

    var newRef = FirebaseDatabase.instance.ref('users/${assignedTo}/assigned');
    newRef.push().set(taskref.key).then((onValue) {
      print('task added to user');
    }).catchError((onError) {
      print('error2');
    });
  }

  static getFamilyMembers(familyID) {
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference familyref =
        database.child('families/${familyID}/members');
    familyref.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        print(key);
        print(value);
      });
    });
  }

  static removeTask(taskID) {
    User? user = FirebaseAuth.instance.currentUser!;

    // remove taskID from under the user
    var newRef = FirebaseDatabase.instance.ref('users/${user.uid}/assigned');
    newRef.child(taskID).remove().then((onValue) {
      print('task removed from user');
      var taskRef = FirebaseDatabase.instance.ref('tasks/$taskID');
      taskRef.remove().then((onValue) {
        print('task removed from tasks');
      }).catchError((onError) {
        print('error3');
      });
    }).catchError((onError) {
      print('error4');
    });
  }
}
