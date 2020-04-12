import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.onPressed, this.text});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.green,
      borderRadius: BorderRadius.circular(32.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 400,
        height: 42.0,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
