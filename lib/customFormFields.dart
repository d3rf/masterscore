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

class CustomSelect extends StatelessWidget{

  String _selectedItem;
  String _label;
  List<String> _itens;
  Function _onChangeValue;
  CustomSelect(this._label,this._itens,this._selectedItem,this._onChangeValue);
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state){
        return InputDecorator(
          decoration: InputDecoration(
              labelText: _label ,
              contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.lightGreen)
              )

          ),
          child: new DropdownButtonHideUnderline(

            child: DropdownButton(
              value: _selectedItem,
              items: _itens.map((value){
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),

                );
              }).toList(),
              onChanged: _onChangeValue,
            ),
          ),

        );
      },

    );
  }
}