// //import 'package:destiny_mobile_app/pages/MyAccount.dart';
// import 'package:destiny_mobile_app/pages/MyAccount.dart';
// import 'package:destiny_mobile_app/pages/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class GetCurrentUser extends StatefulWidget {
//
//   @override
//   _GetCurrentUserState createState() => _GetCurrentUserState();
// }
//
// class _GetCurrentUserState extends State<GetCurrentUser> {
//   @override
//   Widget build(BuildContext context) {
//     if(FirebaseAuth.instance.currentUser() != null){
//       // wrong call in wrong place!
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => MyAccount()
//       ));
//     }
//     else{
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
//     }
//   }
// }





