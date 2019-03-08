import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
  TextInputType typeInput;
  String validation;
  String hint;
  String label;
  bool validateInput = false;
  Function save;
  int lines = 1;

  CustomInput(this.validation,this.validateInput, this.typeInput,  this.label,this.hint, this.save, [this.lines]);

  _validateInput(value){
    print(value);
    if (validateInput == true && value.isEmpty){
      return  validation;
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new TextFormField(
      scrollPadding: EdgeInsets.all(20.0),
      keyboardType: typeInput,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 30.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),

      ),
      maxLines: lines,
    //  validator: (value)=> _validateInput(value),
      onSaved: save ,

    );
  }
}