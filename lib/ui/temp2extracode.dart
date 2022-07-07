// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:studyplanner02/user.dart';
//
// class UserPageRead extends StatefulWidget {
//   const UserPageRead({Key? key}) : super(key: key);
//
//   @override
//   State<UserPageRead> createState() => _UserPageReadState();
// }
//
// class _UserPageReadState extends State<UserPageRead> {
//   @override
//   Widget build(BuildContext context) =>Scaffold(
//     appBar: AppBar(
//       title: Text("reading  users form the db"),
//     ),
//     body: StreamBuilder<List<User>>(
//         stream: readUser(),
//         builder: (context,snapshot){
//           if(snapshot.hasError){
//             return Text(" Something went wrong ${snapshot}");
//           }else if(snapshot.hasData){
//             final users=snapshot.data!;
//             // return ListView(
//             //   children: users.map(buildUser).toList(),
//             // );
//             return
//           }else{
//             return Center(child: CircularProgressIndicator(),);
//           }
//         }
//     ),
//   );
//   Widget buildUser(User user) => ListTile(
//     leading : CircleAvatar(child: Text('${user.age}')),
//     title : Text(user.name),
//     //subtitle:Text(user.birthday.toIso8601String()),
//   );
//   Stream<List<User>> readUser() => FirebaseFirestore.instance.collection('user').snapshots().map((snapshot) =>
//       snapshot.docs.map((doc) => User.fromJson(doc.data())).toList()
//   );
//   Future createUser({required String name}) async{
//     final docUser = FirebaseFirestore.instance.collection('user').doc();
//     final user = User(
//       id:docUser.id,
//       name : name,
//       age : 21,
//       //  birthday : DateTime(2000,7,21),
//     );
//     final json = user.toJson();
//     await docUser.set(json);
//
//   }
//
//
//
// }
//
