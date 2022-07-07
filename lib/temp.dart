// //import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:studyplanner02/User.dart';
// //import 'package:testingapp/main.dart';
//
// import 'main.dart';
//
// class UserPage extends StatefulWidget {
//   const UserPage({Key? key}) : super(key: key);
//
//   @override
//   State<UserPage> createState() => _UserPageState();
// }
//
// class _UserPageState extends State<UserPage> {
//   final controllerid = TextEditingController();
//   final controllername = TextEditingController();
//   final controllerage = TextEditingController();
//   final controllerdate = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("add user to database"),
//       ),
//
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: <Widget>[
//           TextField(
//             controller: controllerid,
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           TextField(
//             controller: controllername,
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           TextField(
//             keyboardType: TextInputType.number,
//             controller: controllerage,
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           //DateTimeField()
//           //   TextField(
//           //     keyboardType: TextInputType.datetime,
//           //     controller: controllerdate,
//           //   ),
//
//           ElevatedButton(
//             child: Text("Create"),
//             onPressed: () {
//               final user = User(
//                 id: controllerid.text,
//                 name: controllername.text,
//                 age: int.parse(controllerage.text),
//                 // birthday: DateTime.parse(controllerdate.text),
//               );
//               createUser(user);
//               // Navigator.pop(context);
//             },
//
//           ),
//         ],
//
//       ),
//     );
//
//
//   }
//
//
//   Future createUser(User user) async{
//     final  docUser = FirebaseFirestore.instance.collection('user').doc();
//     //user.id = docUser.id;
//     final json = user.toJson();
//     await docUser.set(json);
//   }
//
// }