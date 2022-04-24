import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  var onchanged;
  MyTextField(
      {required this.label,
      this.maxLines = 1,
      this.minLines = 1,
      required this.icon,
      this.onchanged});

  @override
  Widget build(BuildContext context) {
    if (onchanged != null) {
      return TextField(
        style: TextStyle(color: Colors.black87),
        minLines: minLines,
        maxLines: maxLines,
        onChanged: onchanged,
        decoration: InputDecoration(
            suffixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black45),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
      );
    } else {
      return TextField(
        style: TextStyle(color: Colors.black87),
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
            suffixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black45),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))),
      );
    }
  }
}
