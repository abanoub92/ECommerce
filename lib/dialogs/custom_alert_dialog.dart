import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String content;
  final Widget action;

  CustomAlertDialog({this.title, this.content, this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        action, //positive action

        //close the dialog action
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("close", style: TextStyle(color: Colors.blue),),
        )
      ],
    );
  }
}