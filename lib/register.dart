import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngo/Roundedbutton.dart';
import 'package:ngo/afterRegister.dart';
import 'package:ngo/categories.dart';
import 'package:ngo/constants.dart';
import 'package:ngo/login.dart';
import 'package:ngo/verification.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'alertUser.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.user});
  final Auth user;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  String a;
  String name;
  String email;
  String password;
  bool showSpinner = false;
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
                      "Join Us",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "Be a part of our family",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kInputFieldDecoration.copyWith(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Name"),
                    ),
                    SizedBox(
                      height: 15.0,
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Email Address'),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RoundedButton(
                      onPressed: () async {
                        RegExp reg = RegExp(pattern);

                        if (name != null &&
                            email != null &&
                            password != null &&
                            reg.hasMatch(email) &&
                            password.length >= 6) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.toLowerCase(),
                                    password: password);

//                          final newUser =
//                              widget.user.createUser(email, password);
                            if (newUser != null) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Verification()));
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          }
//                        on PlatformException {
//                          setState(() {
//                            showSpinner = false;
//                          });
//
//                          var alertDialog = AlertDialog(
//                            titleTextStyle: TextStyle(
//                                color: Colors.white,
//                                fontSize: 30,
//                                fontWeight: FontWeight.w500),
//                            title: Text('Sorry'),
//                            content: Text(
//                              "We can't reach our servers at the moment, please check your internet connection",
//                              style: TextStyle(
//                                  color: Colors.grey,
//                                  fontSize: 20,
//                                  fontWeight: FontWeight.w800),
//                            ),
//                            shape: RoundedRectangleBorder(),
//                            backgroundColor: Colors.transparent,
//                          );
//                          showDialog(
//                              context: (context),
//                              builder: (context) {
//                                return alertDialog;
//                              });
                          //                      }
                          catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            print(e);
                            if (e is PlatformException) {
                              if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                                var alertDialog = AlertDialog(
                                  titleTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                  title: Text('Attention!'),
                                  content: Text(
                                    "User Already Exits",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Back'),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Login'),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                child: LoginScreen()));
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
                              } else {
                                var alertDialog = AlertDialog(
                                  titleTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                  title: Text('Sorry'),
                                  content: Text(
                                    "We can't reach our servers at the moment, please check your internet connection",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  actions: <Widget>[
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
                          }
                        } else if (name == null) {
                          var alertDialog = AlertDialog(
                            titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                            title: Text('Oops!'),
                            content: Text(
                              'Enter your Name',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            shape: RoundedRectangleBorder(),
                            backgroundColor: Colors.transparent,
                          );
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return alertDialog;
                              });
                        } else if (email == null ||
                            !email.contains("@") ||
                            !email.contains(".") ||
                            reg.hasMatch(email)) {
                          var alertDialog = AlertUser(
                            title: 'Oops!',
                            content: 'Enter your email correctly',
                            btnText: 'Back',
                          );
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return alertDialog;
                              });
                        } else if (password.length < 6 && password.length > 0) {
                          var alertDialog = AlertUser(
                            title: 'Oops!',
                            content:
                                'Password must be atleast 6 characters long',
                            btnText: 'Back',
                          );
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return alertDialog;
                              });
                        } else {
                          var alertDialog = AlertUser(
                            title: 'Oops!',
                            content: 'Enter your password',
                            btnText: 'Back',
                          );
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return alertDialog;
                              });
                        }
                      },
                      text: "Register",
                    )
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
