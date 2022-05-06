import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/services/db_tasks.dart';

class myTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DB>(
      create: (ctx) => DB(uid: FirebaseAuth.instance.currentUser!.uid),
      child: Consumer<DB>(builder: (context, data, _) {
        return data.dataMembers.isEmpty
            ? CircularProgressIndicator()
            : Container(
                height: 500,
                width: 500,
                child: ListView.builder(
                  itemCount: data.dataMembers.length,
                  itemBuilder: (context, index) {
                    return GFListTile(
                        titleText: data.dataMembers.keys.elementAt(index),
                        subTitleText:
                            data.dataMembers.values.elementAt(index).toString(),
                        icon: Icon(Icons.task));
                  },
                ),
              );
      }),
    );
  }
}
