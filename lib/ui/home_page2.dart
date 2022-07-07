// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import '../pages/monthly_view.dart';
// import '../pages/weekly_view.dart';
//
// import 'feedback.dart';
// import 'home2.dart';
// import 'home_page.dart';
//
// class HomePage2 extends StatefulWidget {
//   const HomePage2({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage2> createState() => _HomePage2State();
// }
//
// class _HomePage2State extends State<HomePage2> {
//   int currentIndex = 0 ;
//   final screens=[
//     HomePage(),
//     WeeklyView(),
//     MonthlyView(),
//     FeedBack(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        // body: IndexedStack(
//        // children:  screens,
//        // ),
//       body: screens[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//
//           currentIndex:  currentIndex,
//           onTap: (index)=> setState(() {
//             print("navigation bar");
//             currentIndex = index;
//             // _onItemTapped(currentIndex);
//           }),
//           type: BottomNavigationBarType.fixed,
//           // selectedItemColor: Colors.white,
//           iconSize: 20,
//           selectedFontSize: 12,
//           unselectedFontSize: 10,
//           showUnselectedLabels: false,
//           // showSelectedLabels: false,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//               // backgroundColor: Colors.blue,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.view_week),
//               label: "weekly",
//               // backgroundColor: Colors.grey,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.date_range),
//               label: "monthly",
//               // backgroundColor: Colors.white,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.feedback),
//               label: "FeedBack",
//               // backgroundColor: Colors.white,
//             ),
//           ],
//           // selectedItemColor: Colors.amber[800],
//
//         )
//     );
//   }
// }
