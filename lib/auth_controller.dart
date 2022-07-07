// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyplanner02/ui/home_page.dart';
import 'package:studyplanner02/ui/login_page.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  //email,password
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void onReady()
  {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // user wopuld be notified
    _user.bindStream(auth.userChanges());
    ever(_user,_initialScreen);
  }
  _initialScreen(User? user){
    if(user == null)
      {
        print("Login page");
        Get.offAll(()=>LoginPage());
      }
    else
      {
        print("homepage");
        Get.offAll(()=>HomePage());
      }
  }
  // function for registration
   void register(String email,String password) async
{
  try{
    print("create user ");
    print(email);
    print(password);
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }catch(e){
    Get.snackbar("About User", "User message",
    backgroundColor: Colors.redAccent,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text(
      "Account Creation failed ",
      style:TextStyle(
        color:Colors.white,
      )
    ),
      messageText:Text(
        e.toString(),
          style:TextStyle(
            color:Colors.white,
          )
      )
    );
  }
}
  void login(String email,String password) async
  {
    print("Inside login");

    try{
      print("sing in with email and pass");
      print(email);
      print(password);
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print("login in not done");
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
              "login failed ",
              style:TextStyle(
                color:Colors.white,
              )
          ),
          messageText:Text(
              e.toString(),
              style:TextStyle(
                color:Colors.white,
              )
          )
      );
    }
  }
  void signOut() async{

    await auth.signOut();
  }
}