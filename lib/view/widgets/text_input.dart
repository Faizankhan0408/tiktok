import 'package:flutter/material.dart';

import '../../Constants.dart';

class TextInputFiled extends StatelessWidget {

  final TextEditingController controller;
  final IconData  myIcon;
  final String myLabelText;
  final bool toHide;

   TextInputFiled({Key? key,
   required this.controller,
    required this.myLabelText,
    required this.myIcon,
    this.toHide=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller:controller ,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(
            color:borderColor
          )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(
                color:borderColor
            )
        ),
      ),
    );
  }
}
