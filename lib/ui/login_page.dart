import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:studyplanner02/ui/reset.dart';
import 'package:studyplanner02/ui/signup_page.dart';

import '../auth_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void error(String message,bool flag){
    Get.snackbar("About User", "User message",
        backgroundColor: Colors.black54,
        snackPosition: SnackPosition.TOP,
        titleText: Text(
            flag==false ?"Account Creation failed ":	"🙂🙂🙂🙂🙂",
            style:TextStyle(
              color:Colors.white,
            )
        ),
        messageText:Text(
            message,
            style:TextStyle(
              color:Colors.white,
            )
        )
    );
  }
  bool verifyNITCMail(){
    String email= emailController.text.toString();
    print(email);
    email=email.split("@")[1];
    if(email=="nitc.ac.in"){
      print(email);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white ,
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width : w,
              height : h*0.25 ,
              decoration: BoxDecoration(
                image :DecorationImage(
                  image:AssetImage(
                    "image/blue.jfif"
                  ),
                    fit : BoxFit.cover
                ),
              ),
              child: Column(
                  children:[
                    SizedBox(
                      height: h*0.10,
                    ),
                    CircleAvatar(
                      radius: 50,

                      backgroundImage: AssetImage(
                          "image/nitc.png"
                      ),

                      backgroundColor: Colors.white,
                    )
                  ]
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              width: w,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Study Planner NITC",
                        style:TextStyle(
                          fontSize:45,
                          fontWeight: FontWeight.bold,
                )
                      ),
                    ),
                    // Text(
                    //     "Sign in your account",
                    //     style:TextStyle(
                    //       fontSize:20,
                    //       color: Colors.grey[500],
                    //     )
                    // ),
                    SizedBox(
                      height:50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: Offset(1,1),
                            color:Colors.grey.withOpacity(0.4)
                          )
                        ]
                      ),
                      child: TextField(
                        controller: emailController,

                        decoration: InputDecoration(
                            hintText: "Email..?",
                            prefixIcon: Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                             // color:Colors.white,
                              width:1,
                            )
                          ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Colors.transparent,
                                  width:1.0,
                                )
                            ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                        ),

                      ),

                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 7,
                                blurRadius: 10,
                                offset: Offset(1,1),
                                color:Colors.grey.withOpacity(0.4)
                            )
                          ]
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password..?",
                            prefixIcon: Icon(Icons.password),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                 // color:Colors.white,
                                  width:1,
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Colors.white,
                                  width:0.1,
                                )
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(child:Text('Forget Password ?'),onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ResetScreen())),)
                      ],
                    ),

                  ],
                )
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                if(verifyNITCMail()==true){
                  AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                }
                else{
                  error("Please Enter valid NITC Mail", false);
                }

              },
              child:  Container(
                width : 150,
                height : 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image :DecorationImage(
                      image:AssetImage(
                          "image/blue.jfif"
                      ),
                      fit : BoxFit.cover
                  ),
                ),
                child:Center(
                  child: Text(
                      "Sign-In",
                      style:TextStyle(
                        fontSize:30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 120,
            ),
            RichText(text: TextSpan(
              text:"Don't have an account..?",
              style: TextStyle(
                color:Colors.grey[500],
                fontSize: 20,
              ),
              children: [
              TextSpan(
              text:" Create",
              style: TextStyle(
                color:Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
              )
              ],
            )
            )
          ],
        ),
      )
    );
  }
}
