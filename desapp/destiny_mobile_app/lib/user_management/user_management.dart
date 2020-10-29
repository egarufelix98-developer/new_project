import 'package:destiny_mobile_app/supplier/supplier_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserManagement{

  FirebaseUser user;

  // Widget handleAuth(){
  //   return StreamBuilder(
  //     stream: FirebaseAuth.instance.onAuthStateChanged,
  //     builder: (BuildContext context, snapshot){
  //       if(snapshot.hasData){
  //         return LoginHomePage(user: user,);
  //         // Navigator.push(
  //         //     context, MaterialPageRoute(builder: (BuildContext context) => LoginHomePage(user: user,)));
  //         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //         //     LoginHomePage(user: user,)), (Route<dynamic> route) => false);
  //       }
  //       return HomePage();
  //     },
  //   );
  // }

  authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((value){
      Firestore.instance.
      collection("Destiny").
      document("users").
      collection("user_accounts").
      where("Email" ,isEqualTo: value.email.toString()).getDocuments().then((docs){
        if(docs.documents[0].exists){
          if (docs.documents[0].data['User_role'] == "seller"){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => SupplierDashboard())
            );
          }else{
            print('Your Not Authorised To Access This Page');
          }
        }
      });
    });
  }

//   signOut() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('email');
// }

}