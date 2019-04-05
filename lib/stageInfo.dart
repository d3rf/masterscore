import 'package:flutter/material.dart';
import 'package:master_score/customFormFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globalInfo.dart' as globals;
import 'listSubscriptions.dart';
import 'listStages.dart';

class StageInfo extends StatefulWidget  {
  final String stageUid;
  StageInfo(this.stageUid);
  @override
  StageInfoState createState() => new StageInfoState(stageUid);
}

class StageInfoState extends State<StageInfo>{
  final String stageUid;
  StageInfoState(this.stageUid);
  final firestore = Firestore.instance;
  Widget cabecalho = Card(
    child: Text("Carregando informações..."),
  );

  void initState(){
    super.initState();
    firestore.document("cofs/"+stageUid).get().then((stageData){

      setState((){

        cabecalho = Card(
            color: Colors.white,
            elevation: 1.0,
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child:Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                child: Container(
                    padding: EdgeInsets.all(3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: new Text(stageData['nome']),
                          subtitle: new Text(stageData['briefing']),
                          isThreeLine: true,
                        ),

                      ],
                    )
                )

            )
        );
      });
    });

  }
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text("Informações do Torneio",style: TextStyle(color: Colors.white),),
        ),
        body: Column(children: <Widget>[
          cabecalho,
          Flexible(
            child: SubscriptionList(stageUid),
          )
        ],),
    );



  }
}