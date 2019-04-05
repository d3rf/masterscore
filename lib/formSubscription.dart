import 'package:flutter/material.dart';
import 'package:master_score/customFormFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globalInfo.dart' as globals;

class FormSubscription extends StatefulWidget  {
  final String stageUid;
  FormSubscription(this.stageUid);
  @override
  FormSubscriptionState createState() => new FormSubscriptionState(stageUid);

}

class FormSubscriptionState extends State<FormSubscription>{

  final String stageUid;
  final firestore = Firestore.instance;
  FormSubscriptionState(this.stageUid);
  GlobalKey<FormState> _formkeyCreateSubscription= new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> divisao = <String>["PRODUCTION", "LIGHT", "CLASSIC", "REVOLVER", "STANDART","OPEN","MINI RIFLE OPEN"];
  List<String> categoria = <String> ["Overall", "Junior", "Damas ", "Sênior", "Super sênior"];
  List<String> calibre = <String> [".22",".32",".38",".380","9x19mm",".40 ",".45","12 GA",".762","OUTRO"];
  List<String> fator = <String> ["Maior","Menor"];

  String _divisaoSelected;
  String _fatorSelected;
  String _calibreSelected;
  String _categoriaSelected;
  String _result;
  int _radioValue = -1;

  _saveSubscription(){
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

  }
  List<Widget> minhasInscricoes = new List<Widget>();
  Widget cabecalho = Card(
    child: Text("Carregando informações..."),
  );

  @override
  void initState(){
    super.initState();
    minhasInscricoes.add(Text('Buscando suas informações neste torneiro...'));
    _divisaoSelected = divisao[0];
    _fatorSelected = fator[0];
    _calibreSelected = calibre[0];
    _categoriaSelected = categoria[0];
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
                        Column(children: minhasInscricoes,)

                      ],
                    )
                )

            )
        );
      });
    });
  }
  /*
  _getMySubscriptionInCOF(){
    Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("cofs/"+stageUid).where("shooterId",isEqualTo: ).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          return new ListView(children: createChildren(snapshot));
        },
      );
    }
  }
  */
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
                key: _formkeyCreateSubscription,
                child: ListView(
                  children: <Widget>[
                    cabecalho,
                    Padding(padding: EdgeInsets.all(5.0),),
                    CustomSelect("Divisão",divisao,_divisaoSelected,(newValue){
                      setState((){
                        _divisaoSelected = newValue;
                      });
                    }),
                    Padding(padding: EdgeInsets.all(5.0),),
                    CustomSelect("Categoria",categoria,_categoriaSelected,(newValue){
                      setState((){
                        _categoriaSelected = newValue;
                      });
                    }),
                    Padding(padding: EdgeInsets.all(5.0),),
                    CustomSelect("Calibre",calibre,_calibreSelected,(newValue){
                      setState((){
                        _calibreSelected = newValue;
                      });
                    }),
                    Padding(padding: EdgeInsets.all(5.0),),
                    CustomSelect("Fator",fator,_fatorSelected,(newValue){
                      setState((){
                        _fatorSelected = newValue;
                      });
                    }),
                    Padding(padding: EdgeInsets.all(5.0),),
                    RaisedButton(
                      onPressed: ()=>  _saveSubscription(),
                      child: Text('Inscrever-se'),
                    )
                  ],
                ),
              ),
            ),
          )
      );
  }
}