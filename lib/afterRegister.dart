import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngo/Roundedbutton.dart';
import 'package:ngo/login.dart';
import 'package:page_transition/page_transition.dart';

class AfterRegister extends StatefulWidget {
  @override
  _AfterRegisterState createState() => _AfterRegisterState();
}

class _AfterRegisterState extends State<AfterRegister> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: RoundedButton(
              text: 'Sign Out',
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LoginScreen(),
                        type: PageTransitionType.downToUp));
              },
            ),
          ),
        ),
      ),
    );
  }
}
