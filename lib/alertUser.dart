import 'package:flutter/material.dart';

class AlertUser extends StatelessWidget {
  AlertUser(
      {@required this.title, @required this.content, @required this.btnText});
  final String title, content, btnText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
      title: Text(title),
      content: Text(
        content,
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w800),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(btnText),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ],
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.transparent,
    );
  }
}
