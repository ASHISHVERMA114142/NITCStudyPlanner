import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  final Task ? task;
  const NotifiedPage({Key? key,required this.label,required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status=task!.isCompleted.toString();
    if(status=="1"){
      status="Completed";
    }else{
      status="Not Completed";
    }
    return Scaffold(
      backgroundColor: Get.isDarkMode? Colors.black:Colors.black ,
      appBar:  AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_ios,
            color: Get.isDarkMode? Colors.black:Colors.black,
          ),
        ),
        title:  Text(this.label.toString().split("|")[0] ,
          style: TextStyle(
            color: Get.isDarkMode? Colors.white:Colors.black,
          ),),
      ),
      body:
      Center(
        child: Container(

          height: 400,
          width: 350,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode? Colors.black: Colors.blue,

          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.flag,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        task?.title??"",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 30, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.hourglass_bottom_outlined,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 30, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.calendar_month,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        task?.date??"",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 30, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.loop_rounded,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        task?.repeat??"",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 30, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.playlist_add_check,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        status,
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 30, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 13,),
                      Icon(
                        Icons.event_note,
                        color: Colors.grey[200],
                        size:30 ,
                      ),
                      SizedBox(width: 10),
                      Text(
                        task?.note??"",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 25, color: Colors.grey[100]),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),

        ),
      ),
    );
  }
}
