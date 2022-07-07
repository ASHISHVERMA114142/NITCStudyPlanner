import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    getTasks();
    super.onReady();
  }
  var taskList  = <Task>[].obs;

  Future<int> addTask({Task?task}) async {
      return await  DBHelper.insert(task);
  }
  void getTasks() async {
    List<Map<String ,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());

  }
  void delete(Task task){
    var temp = DBHelper.delete(task);
    return temp;
  }
  void markTaskCompleted(int id) async
  {
    await DBHelper.update(id);
    getTasks();
  }
}