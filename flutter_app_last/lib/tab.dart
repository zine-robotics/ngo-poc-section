import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_last/Tab1.dart';
import 'package:flutter_app_last/Tab2.dart';
import 'package:flutter_app_last/welcome_screen.dart';


class tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            bottom: TabBar(
              tabs: [
                Tab(text: 'New', icon: Icon(Icons.add_alert)),
                Tab(text: 'Pending', icon: Icon(Icons.access_time)),
              ],
            ),
            title: Text('AAS'),
          ),
          body: Container(
            child: TabBarView(
              children: [Tab1(), Tab2()],
            ),
          ),
        ),
      ),
      //initialRoute: MyApp.id,
//        routes: {
//          //detailed_view.id:(context) => detailed_view(),
//          Tab1.id: (context) => Tab1(),
//          Tab2.id: (context) => Tab2(),
//          MyApp.id: (context) => MyApp(),
//        },
    );
  }
}


