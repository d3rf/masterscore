import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'formSubscription.dart';
import 'stageInfo.dart';
import 'globalInfo.dart' as globals;

class SubscriptionList extends StatefulWidget{
  final String stageUid;
  SubscriptionList(this.stageUid);

  SubscriptionListState createState() => new SubscriptionListState(stageUid);
}

class SubscriptionListState extends State<SubscriptionList>{
  final String stageUid;
  SubscriptionListState(this.stageUid);
  final _firestore = Firestore.instance;

  _moreInfo(String info){
    return Chip(
      label: Text(info),

    );
  }
  _formResults(String subscriptionUid){

  }

  @override
  Widget build(BuildContext context) {

    return new StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cofs/'+stageUid+'/subscriptions').orderBy('created_at',descending:true ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError){
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting: return new Text('Carregandos pistas');

          default:
            List<GestureDetector> dataToReturn;
            if (snapshot.hasData){
              dataToReturn = snapshot.data.documents.map( (DocumentSnapshot document){
                if (document.exists) {
                  String subscriptionUid = document.documentID;

                  return GestureDetector(
                      onTap: ()=> _formResults(subscriptionUid),
                      child:Card(
                          color: Colors.white,

                          elevation: 1.0,
                          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          child:Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                              child: Container(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                        title: new Text("Atirador: "+document['nome']),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              _moreInfo(document['divisao']),
                                              Text('Divisão'),

                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              _moreInfo(document['calibre']),
                                              Text('Calibre'),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                                _moreInfo(document['categoria']),
                                                Text('Categoria'),

                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  )
                              )

                          )
                      ));

                }else{
                  return GestureDetector(
                      child:Card(
                          child:Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                            child: ListTile(title: new Text ('Não há atiradores'),),
                          )
                      ));
                }
              }).toList();
            }
            return new ListView(children: dataToReturn,);
        }
      },
    );
  }

}