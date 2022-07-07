

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../auth_controller.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../pages/monthly_view.dart';

import '../services/notification_services.dart';
import '../services/theme_services.dart';
import '../ui/add_task_bar.dart';
import '../ui/theme.dart';
// import 'add_task_bar.dart';
// import 'package:untitled/services/theme_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/widgets/buttons.dart';
import '../ui/widgets/task_tile.dart';

bool flag = true;
bool isClose = false;
class MonthlyView extends StatefulWidget {
  const MonthlyView({Key? key}) : super(key: key);

  @override
  _MonthlyViewState createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  AuthController auth = AuthController.instance;
  @override
  void initState(){
    super.initState();
    notifyHelper= NotifyHelper();
    notifyHelper. initializeNotification();
    notifyHelper.requestIOSPermissions();
    // notifyHelper.requestAndroidPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 20),
          _showTasks(),
          // SizedBox(height: 20,),
          // _navigationBar(),
        ],
      ),

    );
  }
  // _onItemTapped(int currentIndex){
  //   if(currentIndex==0){
  //     print("_showTask");
  //     _showTasks();
  //   }else if(currentIndex == 1){
  //     print("_weeklyView");
  //     _weeklyView();
  //   }else if(currentIndex==2){
  //     print("_monthlyView");
  //     _monthlyView();
  //   }
  // }

  // this function will display all the event within that week ...
  _weeklyView(){
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];

              if(task.repeat=='Daily'||task.repeat=='None'){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print("haan bhai sahi jgh ho");
                print(myTime);
                // may proble here ....
                notifyHelper.scheduleNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }
              if(task.date == DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }else{
                return Container();
              }


            });
      }),
    );
  }
  // this function will display all the event within that month...
  _monthlyView(){
    print("monthlyView");
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              print("monthly view");

              print(_selectedDate.runtimeType);
              if(task.repeat=='Daily'||task.repeat=='None'){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print("haan bhai sahi jgh ho");
                print(myTime);
                // may proble here ....
                notifyHelper.scheduleNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }
              if(task.date == DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }else{
                return Container();
              }


            });
      }),
    );
  }



  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];



              String t1 = task.date.toString().split("/")[0];
              String t2 = task.date.toString().split("/")[1];
              print(t1);
              print(t2);
              if(t1.length==1){
                t1="0"+t1;
              }
              if(t2.length==1){
                t2="0"+t2;
              }
              String t3 = task.date.toString().split("/")[2];
              String temp= t3+"-"+t1+"-"+t2;
              print("value of temp");
              print(temp);
              DateTime _targetDateConveted = DateTime.parse(temp.toString());
              print("current selected date is ");
              print(_selectedDate);
              print("iske bad aayega error");
              print("target Date Converted ");
              print(_targetDateConveted.runtimeType);

              print("experiment body");
              DateTime now = new DateTime.now();
              DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
              int v1 =int.parse(lastDayOfMonth.month.toString());
              int v2 =int.parse(lastDayOfMonth.day.toString());
              int dew=  (v1 / v2).ceil();
              print("week");
              print(dew);
              // ==================================

              if(_targetDateConveted.month==_selectedDate.month && _targetDateConveted.year == _selectedDate.year){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print("haan bhai sahi jgh ho");
                print(myTime);
                // may proble here ....
                notifyHelper.scheduleNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }
              if(task.date == DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child:Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      _showBottomSheet(context,task);
                                    },
                                    child:TaskTile(task,true)
                                )
                              ],
                            )
                        )
                    )) ;
              }else{
                return Container();
              }


            });
      }),
    );
  }
  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top:4),
          height:task.isCompleted==1?
          MediaQuery.of(context).size.height*0.24:
          MediaQuery.of(context).size.height*0.34,
          color:Get.isDarkMode?Colors.black:Colors.white,
          child:Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Get.isDarkMode?Colors.yellow:Colors.black,
                ),
              ),
              Spacer(),
              task.isCompleted==1?
              Container()
                  :_bottomSheetButton(
                label : "Task Done",
                onTap:(){
                  _taskController.markTaskCompleted(task.id!);
                  Get.back();
                },
                clr:Colors.blue,
                isClose:false,
                context:context,
              ),

              _bottomSheetButton(
                label : "Remove Task",
                onTap:(){
                  _taskController.delete(task);
                  _taskController.getTasks();
                  Get.back();
                },
                clr:Colors.black,
                isColse:false,
                context:context,
                isClose: false,
              ),
              SizedBox(
                height:30,
              ),
              _bottomSheetButton(
                label : "-CLOSE-",
                onTap:(){
                  Get.back();
                },
                clr:Colors.red,
                isClose:true,
                context:context,
              ),
              SizedBox(
                height:10,
              ),

            ],
          )
      ),
    );
  }
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isColse = false,
    required BuildContext context, required bool isClose,

  })
  {
    return GestureDetector(
        onTap:onTap,
        child:Container(
            margin: const EdgeInsets.symmetric(vertical:4),
            height : 55,
            width : MediaQuery.of(context).size.width*0.9,

            decoration: BoxDecoration(
              border: Border.all(
                width:2,
                color: isClose == true?Colors.black:clr,
              ),
              borderRadius: BorderRadius.circular(20),
              color:isClose==true?Colors.transparent:clr,
            ),

            child : Center(
                child: Text(
                    label,
                    style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white)
                )
            )
        )
    );
  }
  _addDateBar() {

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 50,
        initialSelectedDate: DateTime.now(),
        selectionColor: Get.isDarkMode?Colors.red:Colors.blue,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.grey,
        ),
        dayTextStyle: GoogleFonts.lato(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
        ),
        monthTextStyle: GoogleFonts.lato(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          setState(() {
            selectionColor: Get.isDarkMode?Colors.red:Colors.blue;
            _selectedDate = date;
            // Get.to(AddTaskPage());
            // Get.to(_addDateBar());
          });
        },
      ),
    );
  }

  _navigationBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButton(
              label: "+ monthly View",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }
          ),
          MyButton(
              label: "+ weekly View",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }
          ),
          MyButton(
              label: "Feedback",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }
          )
        ],
      ),
    );
  }
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: HeadingStyle,
                ),
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }
          )
        ],
      ),
    );
  }

  //  Custom appBar...
  bool temp=false;
  _appBar() {
    return AppBar(
      elevation: 0,

      //backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          // print("clicked");

          ThemeService().switchTheme(true);
          // temp =true;

          // selectionColor: Get.isDarkMode?Colors.red:Colors.blue;
          // Get.back();
          // setState(() {
          //   if(temp == true)
          //     {
          //       selectionColor: Get.isDarkMode?Colors.red:Colors.blue;
          //     }
          // });
          print("switch notification is called");
          notifyHelper.displayNotification(
            title: "Theme changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark theme",
          );
          //notifyHelper.scheduleNotification();
        },
        child: Icon(
          Icons.lightbulb,
          size: 23,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: (){
            auth.signOut();
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginPage()));
          },
          child: Icon(
            Icons.power_settings_new,
            size: 28,
          ),
        ),
        SizedBox(
          width: 23,
        ),
      ],
    );
  }
}

