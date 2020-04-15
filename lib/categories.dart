import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ngo/afterRegister.dart';
import 'package:page_transition/page_transition.dart';
import 'alertUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
//  Future<bool> _onWillPop() async {
//    setState(() {
//      showSpinner = true;
//    });
//    await loggedinUser.delete();
//    setState(() {
//      showSpinner = false;
//    });
//    Navigator.pop(context);
//    return true;
//  }

  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;
  var finalList = [];
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  var Tapped = [false, false, false, false, false, false];

  bool onTapped(var a) {
    return !Tapped[a];
  }

  bool select() {
    for (var item in Tapped) {
      if (item) return true;
    }
    return false;
  }

  bool showSpinner = false;
  String imgFood = 'images/food.jpg';
  String checked = 'images/smile.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  color: Colors.white,
                  onPressed: () {
//                    setState(() {
//                      showSpinner = true;
//                    });
////                      await loggedinUser.delete();
//                    setState(() {
//                      showSpinner = false;
//                    });
                    Navigator.pop(context);
                  },
                ),
                Container(width: 125, child: Row())
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 30),
                  child: Text(
                    "Select Categories you deal in",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 105,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 20),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: ListView(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[0] = onTapped(0);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[0]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[0] ? Colors.red : Colors.black,
                              ),
                              text: 'Food',
                              img: 'images/food.jpg',
                              color: Tapped[0] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[1] = onTapped(1);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[1]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[1] ? Colors.red : Colors.black,
                              ),
                              text: 'Shelter',
                              img: 'images/food.jpg',
                              color: Tapped[1] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[2] = onTapped(2);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[2]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[2] ? Colors.red : Colors.black,
                              ),
                              text: 'Clothes',
                              img: 'images/food.jpg',
                              color: Tapped[2] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[3] = onTapped(3);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[3]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[3] ? Colors.red : Colors.black,
                              ),
                              text: 'Women',
                              img: 'images/food.jpg',
                              color: Tapped[3] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[4] = onTapped(4);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[4]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[4] ? Colors.red : Colors.black,
                              ),
                              text: 'Others',
                              img: 'images/food.jpg',
                              color: Tapped[4] ? Colors.teal : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showSpinner = true;
                          });
                          if (select()) {
                            _firestore.collection('categories').add({
                              'Food': Tapped[0],
                              'Clothes': Tapped[2],
                              'Shelter': Tapped[1],
                              'Women': Tapped[3],
                              'Others': Tapped[4],
                              'sender': loggedinUser.email,
                              'initialized': true
                            });

                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: AfterRegister()));
                          } else {
                            var alertDialog = AlertUser(
                              title: 'None Selected',
                              content: 'You must select atleast one category',
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
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Let's go",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({this.ic, this.text, this.img, this.color});
  final Icon ic;
  final String text, img;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(img),
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: ic,
            iconSize: 35,
          )
        ],
      ),
    );
  }
}
