import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngo/register.dart';
import 'package:page_transition/page_transition.dart';
import 'authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'alertUser.dart';
import 'Roundedbutton.dart';

const Color iconColor = Colors.white;
const Color iconTapped = Colors.blue;

class ForgotScreen extends StatefulWidget {
  ForgotScreen({this.auth, this.onSignedin});
  final Auth auth;
  final VoidCallback onSignedin;
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  String email;
  final String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "Let us help you",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Email Address',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    SizedBox(
                      height: 15.0,
                    ),

                    RoundedButton(
                      onPressed: () async {
                        RegExp reg = RegExp(pattern);
                        if (email != null &&
                            reg.hasMatch(email)) {
                          setState(() {
                            showSpinner = true;
                          });
                          try
                          {
                            final exist = await  _auth.fetchSignInMethodsForEmail(email: email).toString();
                            if(exist!=null)
                              {
                                await _auth.sendPasswordResetEmail(
                                    email: email);
                                var alertDialog = AlertUser(
                                  title: 'Success!',
                                  content: 'Please check your email',
                                  btnText: 'Back',
                                );
                                showDialog(
                                    context: (context),
                                    builder: (context) {
                                      return alertDialog;
                                    });
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                          }  on PlatformException {
                            setState(() {
                              showSpinner = false;
                            });
                            var alertDialog = AlertDialog(
                              titleTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                              title: Text('Oops!'),
                              content: Text(
                                'Incorrect Credentials, or no internet Connection',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Register'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                            PageTransitionType.rightToLeft,
                                            child: RegisterScreen(
                                              user: Auth(),
                                            )));
                                  },
                                ),
                                FlatButton(
                                  child: Text('Back'),
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
                            showDialog(
                                context: (context),
                                builder: (context) {
                                  return alertDialog;
                                });
                          }


                        }

                        else {
                          if (email == null ||
                              !email.contains("@") ||
                              !email.contains(".") ||
                              !reg.hasMatch(email)) {
                            var alertDialog = AlertUser(
                              title: 'Oops!',
                              content: 'Enter your email',
                              btnText: 'Back',
                            );
                            showDialog(
                                context: (context),
                                builder: (context) {
                                  return alertDialog;
                                });
                          }
                        }
                      },
                      text: 'Submit',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
