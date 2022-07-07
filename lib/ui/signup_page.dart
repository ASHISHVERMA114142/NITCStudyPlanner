import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:email_auth/email_auth.dart';

import '../auth_controller.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
  // var remoteServerConfiguration = {
  //   "server": "https:://mail-abot.herokuapp.com",
  //   "serverKey": "defkey"
  // };

  bool otpflag = false;
  void sendOTP() async {
    var res = await emailAuth.sendOtp(recipientMail: _emailController.text);
    if (res) {
      print("OTP send");

      error("OTP send Sucessfully", true);
    } else {
      print("OTP is not sent");
      error("Please enter your Email", false);
    }
  }

  void error(String message, bool flag) {
    Get.snackbar("About User", "User message",
        backgroundColor: Colors.black54,
        snackPosition: SnackPosition.TOP,
        titleText:
            Text(flag == false ? "Account Creation failed " : "🙂🙂🙂🙂🙂",
                style: TextStyle(
                  color: Colors.white,
                )),
        messageText: Text(message,
            style: TextStyle(
              color: Colors.white,
            )));
  }

  bool verifyNITCMail() {
    String email = _emailController.text.toString();
    print(email);
    email = email.split("@")[1];
    if (email == "nitc.ac.in") {
      print(email);
      return true;
    }
    return false;
  }

  void verifyOTP() {

    var res = emailAuth.validateOtp(
        recipientMail: _emailController.text, userOtp: _otpController.text);
    if (res) {
      otpflag = true;
    } else {
      otpflag = false;
    }
    // otpflag=true;
  }

  @override
  Widget build(BuildContext context) {
    List images = ["img.png"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("image/blue.jfif"),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  SizedBox(
                    height: h * 0.10,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("image/img.png"),
                  )
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("Register Yourself",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      // Text(
                      //     "Sign in your account",
                      //     style:TextStyle(
                      //       fontSize:20,
                      //       color: Colors.grey[500],
                      //     )
                      // ),
                      SizedBox(
                        height: 50,
                      ),

                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "User Email",
                          prefixIcon: Icon(Icons.mail, color: Colors.black),
                          suffixIcon: TextButton(
                            child: Text("send OTP"),
                            onPressed: () {
                              if (verifyNITCMail() == true)
                                sendOTP();
                              else {
                                error("Please Enter valid NITC Mail", false);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        //obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "User password",
                          prefixIcon: Icon(Icons.password, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        //obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Please Enter your OTP ",
                          prefixIcon: Icon(Icons.confirmation_number,
                              color: Colors.black),
                          suffixIcon: TextButton(
                            child: Text("verify OTP"),
                            onPressed: () => verifyOTP(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(child: Container(),),
                      //     Text(
                      //         "Forgot Your Password",
                      //         style:TextStyle(
                      //           fontSize:20,
                      //           color: Colors.grey[500],
                      //         )
                      //     ),
                      //   ],
                      // ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  otpflag=true;
                  if (otpflag == true) {
                    AuthController.instance.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                  } else {
                    error("Invalid OTP or Please Verify your Email ", false);
                  }
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: AssetImage("image/blue.jfif"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Text("Sign-up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // RichText(
              //   text: TextSpan(
              //       recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
              //       text:"Have an account...?",
              //       style:TextStyle(
              //         fontSize: 20,
              //         color:Colors.grey[500],
              //       )
              //   ),
              // ),
              SizedBox(
                height: 70,
              ),
              RichText(
                  text: TextSpan(
                text: "Already Have an Account..? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                      text: " LOG-IN",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => LoginPage()))
                ],
              )),
            ],
          ),
        ));
  }
}
