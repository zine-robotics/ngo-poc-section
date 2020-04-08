import 'package:flutter/material.dart';

const kInputFieldDecoration = InputDecoration(
  prefixIcon: Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Icon(
      Icons.email,
      color: Colors.white,
    ),
  ),
  fillColor: Colors.white30,
  hintText: "Email Address",
  hintStyle: TextStyle(
    fontSize: 18,
    color: Colors.white,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
