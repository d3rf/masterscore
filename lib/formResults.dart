import 'package:flutter/material.dart';
import 'package:master_score/customFormFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globalInfo.dart' as globals;

class FormResults extends StatefulWidget  {
  final String stageUid;
  final String subscriptionUid;
  FormResults(this.stageUid,this.subscriptionUid);
  @override
  FormResultsState createState() => new FormResultsState(stageUid,subscriptionUid);
}
class FormResultsState extends State<FormResults>{
  final String subscriptionUid;
  final String stageUid;
  FormResultsState(this.stageUid,this.subscriptionUid);

  final firestore = Firestore.instance;

  GlobalKey<FormState> _formkeyCreateSubscription= new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  String _alpha;
  String _charlie;
  String _delta;
  String _miss;
  String _time;


  _saveResult(){
    /*
    _formkeyCreateSubscription.currentState.save();
    print(globals.currentUser);
    firestore.collection("cofs/"+stageUid+"/subscriptions").add({
      'nome':globals.currentUser['name'],
      'shooterUid':globals.userUid,
      'shooterRefs': firestore.document('shooters/'+globals.userUid),
      'divisao':_divisaoSelected,
      'categoria':_categoriaSelected,
      'calibre':_calibreSelected,
      'fator':_fatorSelected,
      'created_at':FieldValue.serverTimestamp(),
    }).then((doc){
      //Navigator.of(context).pop();
      print('foi!');
    }).catchError((error)=>print(error.toString()));
    */
  }

  Widget cabecalho = Card(
    child: Text("Carregando informações..."),
  );

  @override
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
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text("Inscrição para Torneio",style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: Padding(padding: EdgeInsets.all(28.0),
            child: Form(
            ),
          ),
        )
    );
  }

}