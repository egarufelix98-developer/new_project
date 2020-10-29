import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TrackOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Order'),
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
    );
  }
}