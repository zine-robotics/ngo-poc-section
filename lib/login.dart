import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngo/afterRegister.dart';
import 'package:ngo/categories.dart';
import 'package:ngo/register.dart';
import 'package:page_transition/page_transition.dart';
import 'authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'alertUser.dart';
import 'Roundedbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color iconColor = Colors.white;
const Color iconTapped = Colors.blue;

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.onSignedin});
  final Auth auth;
  final VoidCallback onSignedin;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String email;
  String password;
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
                    image: AssetImage('images/login.png'),
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
                      "Welcome",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "Sign-in to continue",
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
                    TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: kInputFieldDecoration.copyWith(
                            hintText: "Password",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ))),
                    SizedBox(
                      height: 15.0,
                    ),
                    RoundedButton(
                      onPressed: () async {
                        RegExp reg = RegExp(pattern);
                        if (email != null &&
                            password != null &&
                            reg.hasMatch(email)) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
//                            final user = widget.auth.signIn(email, password);

                            if (user != null) {
                              try {
                                final loggedinUser = await _auth.currentUser();

                                if (loggedinUser != null) {
                                  if (loggedinUser.isEmailVerified) {
                                    // widget.onSignedin();

                                    try {
                                      final QuerySnapshot result =
                                          await _firestore
                                              .collection('categories')
                                              .where('sender',
                                                  isEqualTo: loggedinUser.email
                                                      .toLowerCase())
                                              .limit(1)
                                              .getDocuments();
                                      final List<DocumentSnapshot> documents =
                                          result.documents;
                                      bool found = documents.length == 1;

                                      if (found) {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: AfterRegister()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: Categories()));
                                      }
                                    } catch (e) {
                                      var alertDialog = AlertUser(
                                        title: 'Oops!',
                                        content:
                                            'We cannot reach our servers right now. Please check your internet connection',
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
//
//                                    _firestore
//                                        .collection('categories')
//                                        .document(loggedinUser.uid)
//                                        .get()
//                                        .then((doc) {
//                                      if (doc.exists) {
//                                        Navigator.push(
//                                            context,
//                                            PageTransition(
//                                                type: PageTransitionType
//                                                    .rightToLeft,
//                                                child: AfterRegister()));
//                                      } else {
//                                        Navigator.push(
//                                            context,
//                                            PageTransition(
//                                                type: PageTransitionType
//                                                    .rightToLeft,
//                                                child: Categories()));
//                                      }
//                                    }).catchError((error) {
//                                      var alertDialog = AlertUser(
//                                        title: 'Oops!',
//                                        content:
//                                            'We cannot reach our servers right now. Please check your internet connection',
//                                        btnText: 'Back',
//                                      );
//                                      showDialog(
//                                          context: (context),
//                                          builder: (context) {
//                                            return alertDialog;
//                                          });
//
//                                      setState(() {
//                                        showSpinner = false;
//                                      });
//                                    });
                                  } else {
                                    var alertDialog = AlertUser(
                                      title: 'Oops!',
                                      content:
                                          'Email is not verified, Please verify your email and try again.',
                                      btnText: 'Back',
                                    );
                                    showDialog(
                                        context: (context),
                                        builder: (context) {
                                          return alertDialog;
                                        });
                                  }

                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  showSpinner = false;
                                });
                                print(e);
                              }
                            }
                          } on PlatformException {
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
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            print(e);
                            print('haha');
                          }
                        } else {
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
                        }
                      },
                      text: 'Login',
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            'Forgot?',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            color: Colors.white,
                            height: 20,
                            width: 2,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                          onTap: () {
                            return Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.downToUp,
                                    child: RegisterScreen()));
                          },
                        )
                      ],
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
