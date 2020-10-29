import 'package:destiny_mobile_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ViewMyProducts extends StatefulWidget {
  @override
  _ViewMyProductsState createState() => _ViewMyProductsState();
}

class _ViewMyProductsState extends State<ViewMyProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('View My Products'),
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()));
            },
            icon: Icon(FontAwesomeIcons.home),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text('Your Products',style: TextStyle(fontSize: 20.0),),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}