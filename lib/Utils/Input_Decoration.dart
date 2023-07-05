import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:roamify/Utils/Color_const.dart';

InputDecoration inputDecoration(
    {required BuildContext context, String? labelText, String? hintText,Color? color,}) {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    // labelText: labelText,
    // labelStyle: secondaryTextStyle(),
    hintText: hintText,
    alignLabelWithHint: true,
    // fillColor: color,
    // filled: true,
    
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: const BorderSide(color: Colors.black, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: BorderSide(color: Colors.black, width: 0.0),
    ),
    filled: true,
    fillColor:color==null? context.cardColor:color,
  );
}
