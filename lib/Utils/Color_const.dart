import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color darkbg = fromHex('#222222');
  static Color darkbluebg = fromHex('#15171b');
  static Color darkblueshade = fromHex('#20242c');
  static Color grayblack = fromHex('#383838');
  static Color grayshade = fromHex('#212121');
  static Color grayblue = fromHex('#1b3a4e');
  static Color greenteal = fromHex('#29e2b0');
  static Color graydark = fromHex('#5d5c5d');
  static Color graydarkshade = fromHex('#1f1f1f');
  static Color graylight = fromHex('#f3f2f2');

  static Color black = fromHex('#121212');
  static Color blue = fromHex('#0d71e9');

  static Color gray5000 = fromHex('#00fcfcfc');

  static Color gray90014 = fromHex('#140d0140');

  static Color gray5001 = fromHex('#fef5f5');

  static Color deepOrangeA200 = fromHex('#ff6b2c');

  static Color blueGray50 = fromHex('#edf2f7');

  static Color whiteA7001e = fromHex('#1effffff');

  static Color blueGray90014 = fromHex('#141f2c37');

  static Color deepPurple400 = fromHex('#8b47ab');

  static Color deepPurple40065 = fromHex('#657850ad');

  static Color gray30059 = fromHex('#59dcdcdc');

  static Color gray50 = fromHex('#fcfcfc');

  static Color red50 = fromHex('#fff2ed');

  static Color gray5065 = fromHex('#65fcfcfc');

  static Color greenA700 = fromHex('#00c566');

  static Color gray20001 = fromHex('#ececec');

  static Color blueGray900 = fromHex('#1f2c37');

  static Color deepOrange400 = fromHex('#ff784b');

  static Color gray70014 = fromHex('#145a5555');

  static Color gray90068 = fromHex('#680d0140');

  static Color gray600 = fromHex('#66707a');

  static Color blueGray5001 = fromHex('#ecf1f6');

  static Color tealA700 = fromHex('#00cc9a');

  static Color gray90002 = fromHex('#171725');

  static Color tealA70065 = fromHex('#6500cc9a');

  static Color gray500 = fromHex('#92929d');

  static Color blueGray400 = fromHex('#78828a');

  static Color blueGray300 = fromHex('#9ca4ab');

  static Color gray90065 = fromHex('#650d0140');

  static Color indigo50 = fromHex('#e3e7eb');

  static Color redA200 = fromHex('#ff4747');

  static Color whiteA700A2 = fromHex('#a2ffffff');

  static Color gray900 = fromHex('#0d0140');

  static Color gray90001 = fromHex('#151517');

  static Color orange50065 = fromHex('#65fe970f');

  static Color red5001 = fromHex('#ffeded');

  static Color gray5094 = fromHex('#94fcfcfc');

  static Color gray200 = fromHex('#eeeeee');

  static Color green50 = fromHex('#e6f9f0');

  static Color gray100 = fromHex('#f6f6f6');

  static Color gray50A2 = fromHex('#a2fcfcfc');

  static Color whiteA70003 = fromHex('#fefefe');

  static Color gray6007c = fromHex('#7c66707a');

  static Color whiteA70001 = fromHex('#fcfcff');

  static Color blueGray9001e = fromHex('#1e2e2f3a');

  static Color whiteA70002 = fromHex('#fdfcff');

  static Color gray9003d = fromHex('#3d1f1d2b');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blueGray40087 = fromHex('#8778828a');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
