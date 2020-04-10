import 'package:flutter/material.dart';
import 'package:ngo/categories.dart';
import 'package:ngo/login.dart';
import 'package:ngo/register.dart';
import 'package:ngo/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Splash());
  }
}
