import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()?onTap;
  const MyButton({Key? key,required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
            color:Get.isDarkMode?Colors.red:Colors.blue,
        ),
        alignment: Alignment.center,
        child:
        Text(
          label,
          style: TextStyle(
              color:Colors.white,
              fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),

    );
  }
}
