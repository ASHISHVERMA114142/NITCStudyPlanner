// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:studyplanner02/ui/widgets/enroll_tile.dart';
// import 'package:studyplanner02/ui/User.dart';
//
//
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
//       appBar: AppBar(
//         title: Text("reading  users form the db"),
//       ),
//       body: StreamBuilder<List<User>>(
//           stream: readUser(),
//           builder: (context,snapshot){
//             if(snapshot.hasError){
//               return Text(" Something went wrong ${snapshot}");
//             }else if(snapshot.hasData){
//               final users=snapshot.data!;
//               return ListView(
//                 children: users.map(buildUser).toList(),
//               );
//               // return Expanded(
//               //   child: Obx(() {
//               //     return ListView.builder(
//               //
//               //         itemBuilder: (_, index) {
//               //           // print(_taskController.taskList.length);
//               //           // Task task = _taskController.taskList[index];
//               //           final user = users.toList();
//               //           User task=user[index];
//               //             return AnimationConfiguration.staggeredList(
//               //                 position: index,
//               //                 child: SlideAnimation(
//               //                     child: FadeInAnimation(
//               //                         child:Row(
//               //                           children: [
//               //                             GestureDetector(
//               //                                 onTap:(){
//               //                                   // _showBottomSheet(context,task);
//               //                                 },
//               //                                 child:EnrollTile(task,false)
//               //                             )
//               //                           ],
//               //                         )
//               //                     )
//               //                 )) ;
//               //           }
//               //         );
//               //   }),
//               // );
//             }else{
//               return Center(child: CircularProgressIndicator(),);
//             }
//           }
//       ),
//     );
//   Widget buildUser(User user) => ListTile(
//     leading : CircleAvatar(child: Text('${user.color}')),
//     title : Text(user.title),
//     //subtitle:Text(user.birthday.toIso8601String()),
//   );
//   Stream<List<User>> readUser() => FirebaseFirestore.instance.collection('Tasks').snapshots().map((snapshot) =>
//       snapshot.docs.map((doc) => User.fromJson(doc.data())).toList()
//   );
//   // Future createUser({required String name}) async{
//   //   final docUser = FirebaseFirestore.instance.collection('user').doc();
//   //   final user = User(
//   //     id:docUser.id,
//   //     name : name,
//   //     age : 21,
//   //     //  birthday : DateTime(2000,7,21),
//   //   );
//   //   final json = user.toJson();
//   //   await docUser.set(json);
//   //
//   // }
//
//
//
//   }
//

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:studyplanner02/User.dart';
import 'package:studyplanner02/ui/User.dart';
import 'package:studyplanner02/ui/widgets/enroll_tile.dart';

class UserPageRead extends StatefulWidget {
  const UserPageRead({Key? key}) : super(key: key);

  @override
  State<UserPageRead> createState() => _UserPageReadState();
}

class _UserPageReadState extends State<UserPageRead> {
  int index = 0;
  late List<String> str;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("reading  users form the db"),
        ),
        body: StreamBuilder<List<User>>(
            stream: readUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(" Something went wrong ${snapshot}");
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                // List<User> temp=users.toList();
                // for(int i=0;i<temp.length;i++){
                //   if(temp[i].enrollment_code=="123456"){
                //     User kk=temp[i];
                //     return ListView(
                //       children: buildUser(kk),
                //     );
                //   }
                // }
                // return Container();
                // print("type");
                // print(users.runtimeType);
                // List<User>temp;
                // for(int i=0;i<users.length;i++){
                //   if(users[i].enrollment_code=='123456'){
                //     temp.add(users[i]);
                //
                //   }
                // }
                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );
  Widget buildUser(User user){
    if(user.enrollment_code=='123456'){
      return AnimationConfiguration.staggeredList(
        // leading : CircleAvatar(child: Text('${user.color}')),
        // title : Text(user.note==null?"null":"not null"),
        //subtitle:Text(user.birthday.toIso8601String()),
        // EnrollTile(user,true),

          position: index,
          child: SlideAnimation(
              child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // _showBottomSheet(context,task);
                          },
                          child: EnrollTile(user, true)   )
                    ],
                  ))));
    }
    return Container();
  }
      // AnimationConfiguration.staggeredList(
      // // leading : CircleAvatar(child: Text('${user.color}')),
      // // title : Text(user.note==null?"null":"not null"),
      // //subtitle:Text(user.birthday.toIso8601String()),
      // // EnrollTile(user,true),
      //
      // position: index,
      // child: SlideAnimation(
      //     child: FadeInAnimation(
      //         child: Row(
      //   children: [
      //     GestureDetector(
      //         onTap: () {
      //           // _showBottomSheet(context,task);
      //         },
      //         child: EnrollTile(user, true)   )
      //   ],
      // ))));
  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('Tasks')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  // Future createUser({required String name}) async{
  //   final docUser = FirebaseFirestore.instance.collection('user').doc();
  //   final user = User(
  //     id:docUser.id,
  //     name : name,
  //     age : 21,
  //     //  birthday : DateTime(2000,7,21),
  //   );
  //   final json = user.toJson();
  //   await docUser.set(json);
  //
  // }

}
