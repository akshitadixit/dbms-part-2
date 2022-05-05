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
  static User? user = FirebaseAuth.instance.currentUser;

  static addUser() {
    DatabaseReference familyref = database.child('families').push();

    database.child('users/${user!.uid}/username').set(user!.displayName);
    database.child('users/${user!.uid}/familyID').set(familyref.key);
    database.child('users/${user!.uid}/photo').set(user!.photoURL);

    familyref.child('head').set(user!.displayName);
    familyref
        .child('members')
        .child(user!.displayName!)
        .set(user!.photoURL!)
        .then((_) {
      print('added user to family');
    });
  }

  // let mum share her familyID with members
  static addUserbyCode(String code) {
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference familyref = database.child('families/$code/members');

    database.child('users/${user!.uid}/username').set(user.displayName);
    database.child('users/${user.uid}/familyID').set(code);
    database.child('users/${user.uid}/photo').set(user.photoURL);

    familyref
        .child(user.displayName!)
        .set(user.photoURL)
        .then((_) => print('added user to family'));
  }

  static addTask(String title, String description, String assignedTo,
      int timestamp, int deadline) {
    DatabaseReference tasksref = database.child('tasks');
    var taskref = tasksref.push();

    taskref.child('title').set(title);
    taskref.child('description').set(description);
    taskref.child('assignedTo').set(assignedTo);
    taskref.child('timestamp').set(timestamp);
    taskref.child('deadline').set(deadline);

    print(taskref);
    print(assignedTo);

    // add taskID in under the user
    database
        .child('users/$assignedTo/tasks')
        .child(taskref.key!)
        .set(taskref.key)
        .then((_) => print('added task to user'));

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
