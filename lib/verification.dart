import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ngo/login.dart';
import 'package:page_transition/page_transition.dart';
import 'alertUser.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;
  bool showSpinner = false;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        user.sendEmailVerification();
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _onWillPop() async {
    setState(() {
      showSpinner = true;
    });
    await loggedinUser.delete();
    setState(() {
      showSpinner = false;
    });
    Navigator.pop(context);
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'A Password has been sent to your email',
                  style: TextStyle(fontSize: 40),
                ),
                FlatButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: LoginScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
