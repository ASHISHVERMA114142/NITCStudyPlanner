import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:studyplanner02/ui/theme.dart';
import 'package:studyplanner02/ui/widgets/buttons.dart';
import 'package:studyplanner02/ui/widgets/task_tile.dart';
import '../auth_controller.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../services/notification_services.dart';
import '../services/theme_services.dart';
import 'add_task_bar.dart';
import 'add_to_firebase.dart';



bool flag = true;
bool isClose = false;
class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  DateTime _selectedDate = DateTime.now();
  // DateTime _selectDay = DateTime
  final _taskController = Get.put(TaskController());
  AuthController auth = AuthController.instance;
  var notifyHelper;
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
          _showTasks()
        ],
      ),
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
              // if(task.repeat=='Daily'||task.repeat=='None'){
              if(task.repeat=='Daily'){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                // print("haan bhai sahi jgh ho");
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
                                    child:TaskTile(task,false)
                                )
                              ],
                            )
                        )
                    )) ;
              }
              if(task.repeat=='Daily' || task.repeat == 'None'){

                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                print("date");
                print(date);
                var myTime = DateFormat("HH:mm").format(date);

                print("haan bhai sahi jgh ho");
                print(myTime);
                // may proble here ....
                notifyHelper.scheduleNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task
                );
              }

              // monthly time
              // print(_selectedDate.month);
              //
              // // testing ...
              // String currentDate= task.date.toString().split(" ")[0];
              // String targetDate = _selectedDate.toString().split(" ")[0];
              // String v1 = (currentDate.toString().split("-")[0]);
              // String v2= (targetDate.toString().split("-")[2]);
              // v1 = v1.split("/")[1];


              //=================================
              // print("value of v1");
              // print(v1);
              // print("value of v2");
              // print(v2);
              // print(_selectedDate);
              String t1 = task.date.toString().split("/")[0];
              String t2 = task.date.toString().split("/")[1];
              // print(t1);
              // print(t2);
              if(t1.length==1){
                t1="0"+t1;
              }
              String t3 = task.date.toString().split("/")[2];
              String temp= t3+"-"+t1+"-"+t2;
              DateTime _targetDateConveted = DateTime.parse(temp);
              print(_targetDateConveted.weekday);

              if(task.repeat=="Monthly" && _selectedDate.day==_targetDateConveted.day){
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
                                    child:TaskTile(task,false)
                                )
                              ],
                            )
                        )
                    )) ;
              }

              // weekly task schedule ...


              if(task.repeat=="Weekly" && _targetDateConveted.weekday==_selectedDate.weekday){
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
                                    child:TaskTile(task,false)
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
                                    child:TaskTile(task,false)
                                )
                              ],
                            )
                        )
                    )) ;
              }
              else{
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
            print("before");
            print(_selectedDate);
            _selectedDate = date;
            print("after");
            print(_selectedDate);
            // Get.to(AddTaskPage());
            // Get.to(_addDateBar());
          });
        },
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
                // await Get.to(AddFireBasePage());
                _taskController.getTasks();

              })
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
            size: 23,
          ),
        ),
        SizedBox(
          width: 23,
        ),
      ],
    );
  }
}
