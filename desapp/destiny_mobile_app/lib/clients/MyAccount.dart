import 'package:destiny_mobile_app/clients/my_orders.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:destiny_mobile_app/pages/AppSignIn.dart';


class MyAccountSignedIn extends StatefulWidget {
  @override
  _MyAccountSignedInState createState() => _MyAccountSignedInState();
}

class _MyAccountSignedInState extends State<MyAccountSignedIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Account'),
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginHomePage()));
            },
            icon: Icon(FontAwesomeIcons.home),
            color: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          SizedBox(height: 10,),
          _createAccountItem(
              icon: FontAwesomeIcons.cartPlus,
              text: 'My Orders',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyOrders()),
                  )),
          SizedBox(height: 10,),
          _createAccountItem(
              icon: FontAwesomeIcons.user,
              text: 'Change Password',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginHomePage()),
                  )),
          SizedBox(height: 10,),
          _createAccountItem(
              icon: Icons.delete,
              text: 'Delete My Account',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginHomePage()),
                  )),
          SizedBox(height: 10,),
          _createAccountItem(
              icon: Icons.settings,
              text: 'Account Settings',
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginHomePage()),
                  )),
        ],
      ),
    );
  }
}


Widget _createAccountItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return Card(
    child: ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      onTap: onTap,
    ),
  );
}