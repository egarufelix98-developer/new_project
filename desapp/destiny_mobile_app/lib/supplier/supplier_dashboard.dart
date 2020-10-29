import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:destiny_mobile_app/pages/ProductDetails.dart';
import 'package:destiny_mobile_app/supplier/upload_camera.dart';
import 'package:destiny_mobile_app/supplier/upload_harddisk.dart';
import 'package:destiny_mobile_app/supplier/upload_headsets.dart';
import 'package:destiny_mobile_app/supplier/upload_keyboards.dart';
import 'package:destiny_mobile_app/supplier/upload_laptop.dart';
import 'package:destiny_mobile_app/supplier/upload_memorycards.dart';
import 'package:destiny_mobile_app/supplier/upload_mouse.dart';
import 'package:destiny_mobile_app/supplier/upload_phonecovers.dart';
import 'package:destiny_mobile_app/supplier/upload_ram.dart';
import 'package:destiny_mobile_app/supplier/upload_screenguards.dart';
import 'package:destiny_mobile_app/supplier/upload_screens.dart';
import 'package:destiny_mobile_app/supplier/upload_smartphone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SupplierDashboard extends StatefulWidget {


  @override
  _SupplierDashboardState createState() => _SupplierDashboardState();
}

class _SupplierDashboardState extends State<SupplierDashboard> {


  String emailData = '';
  String displayNameData = '';

  @override void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailData = prefs.get('email');
      displayNameData = prefs.get('displayName');
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.73,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              _createDrawerHeader(),
              _createDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierDashboard()),
                      )),
              _createDrawerItem(
                  icon: FontAwesomeIcons.caretLeft,
                  text: 'Switch Back To Homepage',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginHomePage()),
                      )),
              _createDrawerItem(
                  icon: Icons.add,
                  text: 'Add New Products',
                  onTap: () => _askFavColor()
                     ),
              _createDrawerItem(
                  icon: Icons.view_comfy,
                  text: 'View My Products',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierDashboard()),
                      )),
              _createDrawerItem(
                  icon: Icons.help_outline,
                  text: 'Help & Support',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierDashboard()),
                      )),
              _createDrawerItem(
                  icon: Icons.help_outline,
                  text: 'FAQs',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierDashboard()),
                      )),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Supplier Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("Destiny").where('product_owner', isEqualTo: emailData).where('product_status', isEqualTo: 'Pending').orderBy('timestamp',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            int length = snapshot.data.documents.length;
            print(snapshot.data);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800, //space largo de cada card
                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data.documents[index];
                  return new Container(
                    child: Row(
                      children: [
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Customer Orders",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  // fontSize: 19.0,
                                ),
                              ),
                              subtitle: Text(length.toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22.0,
                                ),),
                            ),
                          ],
                        ),
                      ],
                    )
                  );
                }
            );
          }
      ),
      );
  }


  Future<String> _askFavColor() async {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Your Product'),
            content: Container(
              width: double.minPositive,
              child: ListView(
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  _createAccountItem(
                      text: 'Laptops',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadLaptops()),
                          )),
                  _createAccountItem(
                      text: 'Smartphones',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadSmartphones()),
                          )),
                  _createAccountItem(
                      text: 'Cameras',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadCameras()),
                          )),
                  Divider(),
                  Text('Computer Accessories'),
                  SizedBox(
                      height:5
                  ),
                  _createAccountItem(
                      text: 'Hard Diks',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadHarddisks()),
                          )),
                  _createAccountItem(
                      text: 'Key Boards',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadKeyBoards()),
                          )),
                  _createAccountItem(
                      text: 'Mouse',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadMouse()),
                          )),
                  _createAccountItem(
                      text: 'RAM Chips',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadRAM()),
                          )),
                  _createAccountItem(
                      text: 'Computer Screens',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadScreens()),
                          )),
                  Divider(),
                  Text('Mobile Accessories'),
                  SizedBox(
                      height:5
                  ),
                  _createAccountItem(
                      text: 'Screen Guards',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadScreenGuards()),
                          )),
                  _createAccountItem(
                      text: 'Headsets',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadHeadsets()),
                          )),
                  _createAccountItem(
                      text: 'Memory Cards',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadMemoryCards()),
                          )),
                  _createAccountItem(
                      text: 'Phone Covers',
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UploadPhoneCovers()),
                          )),
                ],
              ),
            ),
          );
        });
  }

  Widget _createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            color: Colors.red[700],
            padding: EdgeInsets.all(20),
            child: Center(
              child: Image.asset(
                'assets/images/ic_app_icon.jpg',
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Start Shopping With Us Today",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.black54
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

Widget _createAccountItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.red[700],fontSize: 19.0),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
}