import 'package:destiny_mobile_app/clients/FAQ.dart';
import 'package:destiny_mobile_app/clients/MyAccount.dart';
import 'package:destiny_mobile_app/clients/productdetails.dart';
import 'package:destiny_mobile_app/pages/ContactUs.dart';
import 'package:destiny_mobile_app/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destiny_mobile_app/components/search.dart';
import 'package:destiny_mobile_app/user_management/user_management.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginHomePage extends StatefulWidget {



  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHomePage>
    with SingleTickerProviderStateMixin {




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
            .width * 0.75,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createDrawerHeader(),
              _createDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    }),
              _createDrawerItem(
                  icon: Icons.business,
                  text: 'Switch To Supplier Account',
                  onTap: (){
                    UserManagement().authorizeAccess(context);
                  }),
              _createDrawerItem(
                  icon: Icons.supervised_user_circle,
                  text: 'My Account',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAccountSignedIn()),
                      )),
              _createDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FAQ()),
                      )),
              _createDrawerItem(
                  icon: Icons.help_outline,
                  text: 'FAQs',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FAQ()),
                      )),
              _createDrawerItem(
                  icon: Icons.help_outline,
                  text: 'Help & Support',
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (BuildContext context) => ContactUs()));
                    // Navigator.pushAndRemoveUntil(context,
                    //     MaterialPageRoute(builder: (context) => ContactUs()), (route) => false);
                  }),
              _createDrawerItem(
                  icon: Icons.power_settings_new,
                  text: 'Log Out',
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('email');
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                    Fluttertoast.showToast(
                      msg: "You Signed Out",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red[700],
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                    );
                  })
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          "assets/images/ic_app_icon.jpg",
          width: 120,
          height: 70,
        ),
        backgroundColor: Colors.red[700],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.userCircle),
            color: Colors.white,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SearchBar(),
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(tabs: [
                Tab(text: "All Categories"),
                Tab(text: "Laptops"),
                Tab(text: "Phones"),
                Tab(text: "Cameras"),
                Tab(text: "Accessories"),
              ],
                isScrollable: true,
                labelColor: Colors.red,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.blue,
                labelPadding: EdgeInsets.fromLTRB(17, 10, 17, 10),
                labelStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: TabBarView(children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection("Destiny").where('product_status', isEqualTo: "available").orderBy('timestamp',descending: true).snapshots(),
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
                                child: SizedBox(
                                  child: Card(
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                            child: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${doc.data["product_category"]}%2F${doc.data["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4' + '?alt=media',
                                                width: 100,
                                                height: 130,
                                                fit:BoxFit.fill

                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              doc.data["product_brand"],
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                // fontSize: 19.0,
                                              ),
                                            ),
                                            subtitle: Text("UGX "+doc.data["price"],
                                              style: TextStyle(
                                                color: Colors.red,
                                                // fontSize: 15.0,
                                              ),),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Destiny").where('product', isEqualTo: "Laptops").where('product_status', isEqualTo: "available").orderBy('timestamp',descending: true).snapshots(),
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
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${doc.data["product_category"]}%2F${doc.data["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4' + '?alt=media',
                                              width: 100,
                                              height: 130,
                                              fit:BoxFit.fill

                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            doc.data["product_brand"],
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              // fontSize: 19.0,
                                            ),
                                          ),
                                          subtitle: Text("UGX "+doc.data["price"],
                                            style: TextStyle(
                                              color: Colors.red,
                                              // fontSize: 15.0,
                                            ),),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Destiny").where('product', isEqualTo: "Smartphones").where('product_status', isEqualTo: "available").orderBy('timestamp',descending: true).snapshots(),
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
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${doc.data["product_category"]}%2F${doc.data["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4' + '?alt=media',
                                              width: 100,
                                              height: 130,
                                              fit:BoxFit.fill

                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            doc.data["product_brand"],
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              // fontSize: 19.0,
                                            ),
                                          ),
                                          subtitle: Text("UGX "+doc.data["price"],
                                            style: TextStyle(
                                              color: Colors.red,
                                              // fontSize: 15.0,
                                            ),),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                              ),
                                            );
                                          },
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: <Widget>[
                                        //     Container(
                                        //       child: new Row(
                                        //         children: <Widget>[
                                        //           RaisedButton.icon(
                                        //             icon: Icon(
                                        //               Icons.remove_red_eye,
                                        //               color: Colors.white,
                                        //             ),
                                        //             onPressed: () {
                                        //               Navigator.push(
                                        //                 context,
                                        //                 MaterialPageRoute(
                                        //                   builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
                                        //                 ),
                                        //               );
                                        //             },
                                        //             label: Text("View Product",style: TextStyle(color: Colors.white)),
                                        //             color: Colors.red[700],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Destiny").where('product', isEqualTo: "Cameras").where('product_status', isEqualTo: "available").orderBy('timestamp',descending: true).snapshots(),
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
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${doc.data["product_category"]}%2F${doc.data["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4' + '?alt=media',
                                              width: 100,
                                              height: 130,
                                              fit:BoxFit.fill

                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            doc.data["product_brand"],
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              // fontSize: 19.0,
                                            ),
                                          ),
                                          subtitle: Text("UGX "+doc.data["price"],
                                            style: TextStyle(
                                              color: Colors.red,
                                              // fontSize: 15.0,
                                            ),),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                              ),
                                            );
                                          },
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: <Widget>[
                                        //     Container(
                                        //       child: new Row(
                                        //         children: <Widget>[
                                        //           RaisedButton.icon(
                                        //             icon: Icon(
                                        //               Icons.remove_red_eye,
                                        //               color: Colors.white,
                                        //             ),
                                        //             onPressed: () {
                                        //               Navigator.push(
                                        //                 context,
                                        //                 MaterialPageRoute(
                                        //                   builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
                                        //                 ),
                                        //               );
                                        //             },
                                        //             label: Text("View Product",style: TextStyle(color: Colors.white)),
                                        //             color: Colors.red[700],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Destiny").where('product', isEqualTo: "Accessories").where('product_status', isEqualTo: "available").orderBy('timestamp',descending: true).snapshots(),
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
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${doc.data["product_category"]}%2F${doc.data["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4' + '?alt=media',
                                              width: 100,
                                              height: 130,
                                              fit:BoxFit.fill

                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            doc.data["product_brand"],
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              // fontSize: 19.0,
                                            ),
                                          ),
                                          subtitle: Text("UGX "+doc.data["price"],
                                            style: TextStyle(
                                              color: Colors.red,
                                              // fontSize: 15.0,
                                            ),),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetailsSignedIn(passed: snapshot.data.documents[index]),
                                              ),
                                            );
                                          },
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: <Widget>[
                                        //     Container(
                                        //       child: new Row(
                                        //         children: <Widget>[
                                        //           RaisedButton.icon(
                                        //             icon: Icon(
                                        //               Icons.remove_red_eye,
                                        //               color: Colors.white,
                                        //             ),
                                        //             onPressed: () {
                                        //               Navigator.push(
                                        //                 context,
                                        //                 MaterialPageRoute(
                                        //                   builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
                                        //                 ),
                                        //               );
                                        //             },
                                        //             label: Text("View Product",style: TextStyle(color: Colors.white)),
                                        //             color: Colors.red[700],
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
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
            child: Text("Start Shopping With Us Today",textAlign: TextAlign.center,
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
          padding: EdgeInsets.only(left: 15.0),
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