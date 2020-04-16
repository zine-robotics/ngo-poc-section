import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ngo/Roundedbutton.dart';
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
          child: SafeArea(
            child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/register.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'A Link has been sent to your Email Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Lato',
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                            RoundedButton(
                              onPressed:() async{
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.downToUp,
                                      child: LoginScreen()));},
                              text:"Login"
                            ),
                        SizedBox(
                          height: 15.0,
                        ),
                           RoundedButton(
                             onPressed: ()async
                             {
                               final result = await InternetAddress.lookup('google.com');
                               try {
                                 final user = await _auth.currentUser();
                                 if (user != null && result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                   user.sendEmailVerification();
                                   loggedinUser = user;
                                   var alertbox=AlertUser(
                                     title: 'Success!',
                                     content: 'Please check your email',
                                     btnText: 'Back',
                                   );
                                   showDialog(
                                       context: (context),
                                       builder: (context) {
                                         return alertbox;
                                       });
                                 }
                                 else
                                   {
                                     var alertbox=AlertUser(
                                       title: 'Oops!',
                                       content: "Task failed, Please try again",
                                       btnText: 'Back',
                                     );
                                     showDialog(
                                         context: (context),
                                         builder: (context) {
                                           return alertbox;
                                         });
                                   }

                               } catch(e) {
                                print(e);

                               }
                             },


                             text: "Resend Email",
                           ),

                      ],
                    )

                  ),

                ],

            ),
          ),
        ),
      ),
    );
  }
}
