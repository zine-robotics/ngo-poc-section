import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class detailed_view extends StatelessWidget {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String loggedInUser;
  DocumentSnapshot document;
  static String id = "detailed_view";

  detailed_view({Key key, @required this.document, this.loggedInUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String address = document.data['address'],
        note = document.data['note'],
        time = document.data['time'],
        img_url = document.data['img_url'],
        location = document.data['city'],
        submitted_by = document.data['submitted_by'],
        submitter_phone_no = document.data['submitter_phone_no'];
    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 10.0,
              color: Colors.white,
              child: Image.network(
                img_url,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('$note.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 17.0,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(time,
                        style: TextStyle(
                          color: Colors.white70,
                        )),
                  )
                ],
              ),
            ),
            Container(
                height: 1.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.4,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Address: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        fontSize: 17.0,
                      )),
                  Expanded(
                    child: Text(address,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17.0,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text("Submitted by: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        fontSize: 17.0,
                      )),
                  Expanded(
                    child: Text(submitted_by,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17.0,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text("Phone NO. ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        fontSize: 17.0,
                      )),
                  Expanded(
                      child: Text(submitter_phone_no,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17.0,
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _firestore.collection('requests_accepted').add({
                          'img_url': img_url,
                          'city': location,
                          'address': address,
                          'note': note,
                          'time': time,
                          'submitted_by': submitted_by,
                          'submitter_phone_no': submitter_phone_no,
                          'accepted_by': loggedInUser,
                        });
                        document.reference.delete();
                        Navigator.pop(context);
                      },
                      child: Text("Accept"),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
