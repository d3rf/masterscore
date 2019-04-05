import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'listStages.dart';
  import 'globalInfo.dart' as globals;

  class Home extends StatefulWidget{
  var userLogged;
  Home(this.userLogged);

  @override
  HomeState createState()=>new HomeState(userLogged);
  }


  class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  FirebaseUser user;
  var userData;
  final firestore = Firestore.instance;
  Widget floatButton = null;
  TabController _tabController;
  HomeState(this.user);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _checkIfAdminUser();
  }
  _checkIfAdminUser(){
    firestore.document('admins/'+user.uid).get().then((userDoc) {
      if (userDoc.exists) {
        setState((){
          userData = userDoc.data;
          globals.isAdmin = true;
          globals.currentUser = userDoc.data;
          globals.userUid = user.uid;
          floatButton = FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: Icon(Icons.add),
            onPressed: ()=> Navigator.of(context).pushNamed("/formStages") ,
          );
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          floatingActionButton:floatButton ,
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.pages)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.public)),
              ],
            ),
            title: Text('Master Score'),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ListStages(),
              Icon(Icons.directions_transit),
              Icon(Icons.publish),
            ],
          ),
        ),

    );
  }
}