import 'package:flutter/material.dart';
import 'package:master_score/CustomInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class FormStages extends StatefulWidget  {

  @override
  FormStagesState createState() => new FormStagesState();

}
class FormStagesState extends State<FormStages>{
  GlobalKey<FormState> _formkeyCreateStage = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final firestore = Firestore.instance;

  final formats = {
    InputType.both: DateFormat("dd/MM/yyyy HH:mm"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  String _nome;
  String _briefing;
  String _clube;
  int _alvos;
  DateTime _data;

  _saveStage(){
    if(_formkeyCreateStage.currentState.validate()){
      _formkeyCreateStage.currentState.save();
      firestore.collection("cofs").add({
        'nome':_nome,
        'briefing':_briefing,
        'clube':'ccte',
        'alvos':_alvos,
        'data': _data,
        'created_at':FieldValue.serverTimestamp()
      }).then((doc){
        Navigator.of(context).pop();
      });

    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Salvar Prova",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(28.0),
          child: Form(
            key: _formkeyCreateStage,
            child: ListView(
              children: <Widget>[
                DateTimePickerFormField(
                  inputType: InputType.both,
                  format: formats[InputType.both],
                  editable: true,
                  decoration: InputDecoration(
                      labelText: 'Data do Evento', hasFloatingPlaceholder: false),
                  onSaved: (dateChoose)=> _data = dateChoose,

                ),
                Padding(padding: EdgeInsets.all(5.0),),
                CustomInput("Informe o nome", true, TextInputType.text, "Nome",'Nome da prova',(value) => _nome = value),
                Padding(padding: EdgeInsets.all(5.0),),
                CustomInput("", false, TextInputType.number, "Alvos",'Quantos alvos possui?',(value) => { _alvos = (value.toString().length >0)?int.parse(value.toString()):0} ),
                Padding(padding: EdgeInsets.all(5.0),),
                CustomInput("", false, TextInputType.multiline, "Descrição",'Faça um breve briefing da prova',(value) => _briefing = value,6),
                Padding(padding: EdgeInsets.all(5.0),),
                RaisedButton(
                  onPressed: ()=> _saveStage(),
                  child: Text('Salvar'),
                )


              ],
            ),
          ),
        ),
      )
    );
  }
}