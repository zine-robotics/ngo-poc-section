import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_last/detailed_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class Tab1 extends StatefulWidget {
  static String id = "Tab1";
  @override
  _Tab1State createState() => _Tab1State();
}

final _firestore = Firestore.instance;

class _Tab1State extends State<Tab1> {
  @override
  void initState() {
    super.initState();
    login();
    getCurrentUser();
  }

  void login() async {
    try {
      final User = await _auth.signInWithEmailAndPassword(
          email: 'sonali@gmail.com', password: 'muskan');
      if (User != null) {}
    } catch (e) {
      print(e);
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('requests').snapshots(),
                builder: (contex, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data.documents;
                    List<Padding> messageWidgets = [];
                    for (var message in messages) {
                      final img_url = message.data["img_url"];
                      final address = message.data["address"];
                      final note = message.data["note"];
                      final time = message.data["time"];
                      final city = message.data["city"];
                      //final username= name from logged in user
                      //final user phone no.= from logged in user
                      final messageWidget = Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(0.0),
                              elevation: 5.0,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: <Widget>[
                                              Image.network(
                                                img_url,
                                                height: 75.0,
                                                width: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
                                                    'Location : $city',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  time,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15.0,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          detailed_view(
                                                              document: message,
                                                              loggedInUser:
                                                                  loggedInUser
                                                                      .email)));
                                            },
                                            color: Colors.lightBlueAccent,
                                            child: Text('View'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      messageWidgets.add(messageWidget);
                    }
                    return Expanded(
                        child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      children: messageWidgets,
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
