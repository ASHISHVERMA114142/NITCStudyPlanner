import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth_controller.dart';
import 'login_page.dart';


class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
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
                height : h*0.3 ,
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



                        radius: 70,
                        backgroundImage: AssetImage(
                            "image/nitc.png"
                        ),
                        backgroundColor: Colors.white,
                      )
                    ]
                ),
              ),
              SizedBox(height: 30,),
              Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  width: w,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                            "Reset Password",
                            style:TextStyle(
                              fontSize:40,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
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
                        height: 20,
                      ),



                    ],
                  )
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: (){
                 if(verifyNITCMail()==true)
                   {
                     AuthController.instance.auth.sendPasswordResetEmail(email: emailController.text.trim());
                     Navigator.of(context).pop();
                   }
                 else
                   {
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
                        "Send Request",
                        style:TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(child:Text('Log-In..'),onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=> LoginPage())),)
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

            ],
          ),
        )
    );
  }
}
