import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'formSubscription.dart';
import 'globalInfo.dart' as globals;
class ListStages extends StatefulWidget{
  @override
  ListStagesState createState() => new ListStagesState();
}
class ListStagesState extends State<ListStages>{
  final _firestore = Firestore.instance;

  _stageDetails(String docUid){
    if (globals.isAdmin){
      //Navigator.of(context).pushNamed("/stage", arguments: docUid);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cofs').orderBy('data',descending:true ).snapshots(),
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
                  String stageUid = document.documentID;
                  //var dataEvento = DateTime(document['data']);
                  var dataFormatada = DateFormat('dd/M/yyyy HH:mm').format(document['data']);
                  String inscritos = document['qtdInscritos'] ?? "0";
                  return GestureDetector(
                    onTap: _stageDetails(document.documentID),
                    child:Card(
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
                              title: new Text(document['nome']),
                              subtitle: new Text(document['briefing']),
                              isThreeLine: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(CommunityMaterialIcons.clock_outline),
                                    Padding(padding: EdgeInsets.all(5.0),),
                                    Text(dataFormatada)
                                  ],
                                )
                                ,
                                Column(
                                  children: <Widget>[
                                    Icon(CommunityMaterialIcons.account_group),
                                    Padding(padding: EdgeInsets.all(5.0),),
                                    Text(inscritos)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(CommunityMaterialIcons.target),
                                    Padding(padding: EdgeInsets.all(5.0),),
                                    Text("8")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(CommunityMaterialIcons.clock_in,color: Colors.lightGreen ,) ,
                                      iconSize: 58,
                                      splashColor: Theme.of(context).primaryColor,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FormSubscription(stageUid)
                                          ),
                                        );
                                      },
                                    ),
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
                        child: ListTile(title: new Text ('Não há pistas recebendo inscrições'),),
                      )
                  ));
                }
              }).toList();
            }
            return new ListView(children: dataToReturn,);
        }
      },
    );;
  }

}

/*

return new StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cofs').where('end',isEqualTo: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError){
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting: return new Text('Carregandos pistas');

          default:
            List<ListTile> dataToReturn;
            if (snapshot.hasData){
              dataToReturn = snapshot.data.documents.map( (DocumentSnapshot document){
                if (document.exists) {
                  return new ListTile(
                    title: new Text(document['name']),
                    subtitle: new Text(document['number_subscriptions']),
                  );
                }else{
                  return ListTile(title: new Text ('Não há pistas recebendo inscrições'),);
                }
              }).toList();
            }
            return new ListView(children: dataToReturn,);
        }
      },
    );

 */