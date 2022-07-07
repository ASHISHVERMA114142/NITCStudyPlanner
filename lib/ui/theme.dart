import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Themes{
  static final light= ThemeData(
    backgroundColor: Color(0x2955D6EF),
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: Colors.black,
    primarySwatch: Colors.red,
    brightness: Brightness.light,
  );
}

// theme: ThemeData(
//   // primarySwatch: Colors.blue,
//   // brightness: Brightness.dark,
//   colorScheme: ColorScheme(
//     brightness: Brightness.light,
//     primary: Colors.green,
//     onPrimary: Colors.black,
//     // Colors that are not relevant to AppBar in LIGHT mode:
//     primaryVariant: Colors.blue,
//     secondary: Colors.blue,
//     secondaryVariant: Colors.blue,
//     onSecondary: Colors.blue,
//     background: Colors.blue,
//     onBackground: Colors.blue,
//     surface: Colors.blue,
//     onSurface: Colors.grey,
//     error: Colors.grey,
//     onError: Colors.grey,
//   ),
// ),

TextStyle get subHeadingStyle{
  return GoogleFonts.lato (
     textStyle:TextStyle(
       fontSize: 20,
       fontWeight:FontWeight.bold,
       color: Get.isDarkMode?Colors.grey[400]:Colors.grey,
     )
  );
}

TextStyle get HeadingStyle{
  return GoogleFonts.lato (
      textStyle:TextStyle(
        fontSize: 24,
        fontWeight:FontWeight.bold,
        color: Get.isDarkMode?Colors.white:Colors.black,
      )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato (
      textStyle:TextStyle(
        fontSize: 16,
        fontWeight:FontWeight.bold,
        color: Get.isDarkMode?Colors.white:Colors.black,
      )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato (
      textStyle:TextStyle(
        fontSize: 14,
        fontWeight:FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[300]:Colors.grey[500],
      )
  );
}