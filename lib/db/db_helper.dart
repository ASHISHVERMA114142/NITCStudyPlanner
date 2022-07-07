import 'package:sqflite/sqflite.dart';

import '../models/task.dart';


class DBHelper{
  static  Database? _db;
  static final int _versoin = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async{
    if(_db!=null){
      return ;
    }
    try{
      String _path = await getDatabasesPath()+"tasks.db";
      _db = await openDatabase(
        _path,
        version: _versoin,
        onCreate: ( db,version){
          print("Creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName (" "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING, note TEXT ,date STRING,"
                "startTime STRING , endTime  STRING, "
                "remind INTEGER , repeat STRING ,"
                "color INTEGER,"
                "isCompleted INTEGER)",
          );
        },
      );
    } catch(e){
      print(e);
    }
  }
  static Future<int> insert(Task?task) async{
    print("insert function called");

      var temp=await _db?.insert(_tableName, task!.toJson())??1;
      // print("this is value of temp "+"$temp");
      return temp;
  }
  static Future<List<Map<String,dynamic>>> query() async{
    print("in query function ");
   return await _db!.query(_tableName);
}
  static delete(Task task) async{
   return await _db!.delete(_tableName ,where: 'id=?' , whereArgs : [task.id]);
  }
  static update(int id) async{
     return await _db!.rawUpdate('''
     UPDATE tasks
     SET isCompleted = ?
     where id =? 
     ''',[1,id]);
  }
}