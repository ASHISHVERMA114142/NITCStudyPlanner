
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';





class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150,),
                Center(
                  child: const Text(
                    "FeedBack",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height :100,
                ),

                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email ??",
                    prefixIcon: Icon(Icons.mail, color: Colors.black),
                  ),
                ),
                // TextField(
                //   controller: passwordController,
                //   obscureText: true,
                //   decoration: const InputDecoration(
                //     hintText: "Password",
                //     prefixIcon: Icon(Icons.password, color: Colors.black),
                //   ),
                // ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Your FeedBack...",
                    prefixIcon: Icon(Icons.message, color: Colors.black),
                  ),
                ),

                const SizedBox(
                  height: 90.0,
                ),
                // login button ...
                SizedBox(height: 18 ,),

                Center(
                  child: Container(
                    width: 120,
                    child: RawMaterialButton(
                      fillColor: Colors.blueGrey,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        final String email = emailController.text.trim();
                        final String name = nameController.text.trim();
                        final String message = messageController.text.trim();
                        // final String password = passwordController.text.trim();

                        final String password = " ";
                        if(email.isEmpty){
                          print("Email is Empty");
                        } else {
                          if(password.isEmpty){
                            print("Password is Empty");
                          } else {
                            context.read<AuthService>().signUp(
                              email,
                              password,

                            ).then((value) async {
                              User? user = FirebaseAuth.instance.currentUser;

                              await FirebaseFirestore.instance.collection("FeedBack").doc(user?.uid).set({
                                'uid': user?.uid,
                                'email': email,
                                'name': name,
                                'message': message,
                              });
                              // user=null;
                            });
                            // Get.to(()=>HomePage2());
                            // Get.to(()=>MainScreen());
                          }
                        }
                      },

                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                // login button....
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



