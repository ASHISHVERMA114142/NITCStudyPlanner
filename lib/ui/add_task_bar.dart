
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:studyplanner02/ui/theme.dart';
import 'package:studyplanner02/ui/widgets/buttons.dart';
import 'package:studyplanner02/ui/widgets/input_field.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final  TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime =DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedReminder =5 ;
  List<int> reminderList=[
    5,
    10,
    15,
    20
  ];

  String _selectedRepeat ="None" ;
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context ),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,top :10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task ",
              style: HeadingStyle,),
              MyInputField(title: "Title",hint: "Enter your title",controller: _titleController,),
              MyInputField(title: "Note",hint: "Enter your notes",controller: _noteController,),
              MyInputField(title: "Date",hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon:Icon(Icons.calendar_today_outlined,
                  color: Colors.grey,),
                  onPressed: (){
                     _getDateFromUser();
                  },

                ),),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded,
                        color: Colors.grey,
                        ),
                        onPressed: (){
                           _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: (){
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),
              MyInputField(title: "Reminder", hint: "$_selectedReminder minutes early",
              widget: DropdownButton(
                icon:Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,
                ),
                iconSize: 32 ,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedReminder =  int.parse(newValue!);
                  });
                },
                items: reminderList.map<DropdownMenuItem <String> >((int value ){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                      child: Text(value.toString()),
                  );
                }
                ).toList(),
              ),
              ),

              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon:Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32 ,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat =  newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem <String> >((String? value ){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,style: TextStyle(
                        color: Colors.grey,

                      ) ),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  _colorPallet(),
                  MyButton(label: "Create Task", onTap: ()=> _validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _validateData(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDB();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isNotEmpty){
      Get.snackbar("Required ", "All fields are required! ");
      snackPosition: SnackPosition.BOTTOM;
      backgroundColor: Colors.white;
      colorText: Colors.cyanAccent;
      barBlur: 12;
      icon: Icon(Icons.warning_amber_rounded);


    }
    return "";
  }
  _addTaskToDB() async {
     int value = await   _taskController.addTask(
           task:Task(
             note:_noteController.text,
             title: _titleController.text,
             date : DateFormat.yMd().format(_selectedDate),
             startTime: _startTime,
             endTime : _endTime,
             remind : _selectedReminder,
             repeat: _selectedRepeat,
             color: _selectedColor,
             isCompleted: 0,
           )

       );
     print("MY taskID " +"$value");
  }
  _colorPallet(){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [

        Text("Color\n",
          style: titleStyle,
        ),
        Wrap(
            children:List<Widget>.generate(3,
                    (int index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        _selectedColor=index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        radius: 11,

                        backgroundColor: index==0?Colors.lightBlueAccent:index==1?Colors.blueGrey:Colors.pink,
                        child: _selectedColor==index?Icon(Icons.circle,
                          color: Colors.black54,
                          size: 13,
                        ):Container(),
                      ),
                    ),
                  );
                }
            )
        )
      ],
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      // backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:(){

           Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 23,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "image/img.png"
          ),
        ),
        SizedBox(width: 23,),

      ],
    );
  }
  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222),
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }
  _getTimeFromUser({required bool isStartTime}) async{
     var pickedTime = await _showTimePicker();
     String _formatedTime = pickedTime.format(context);
     if(pickedTime==null){
       print("invalid time");
     }else if(isStartTime==true){
       setState(() {
         _startTime=_formatedTime;
       });
     }else if(isStartTime==false){
       setState(() {
         _endTime=_formatedTime;
       });
     }
  }
  _showTimePicker(){

    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])
        )
    );
  }
}

