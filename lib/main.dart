import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studyplanner02/temp2.dart';
import 'package:studyplanner02/ui/login_page.dart';
import 'auth_controller.dart';
import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await DBHelper.initDb();
  await GetStorage.init();
  // runApp(const MyApp());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor: Colors.red,
          brightness: Brightness.light
      ),
      darkTheme: ThemeData(
          primaryColor: Colors.red,
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      home:LoginPage(),
      // home:UserPageRead(),
    );

  }
}