import 'package:destiny_mobile_app/pages/ContactUs.dart';
import 'package:destiny_mobile_app/pages/ProductDetails.dart';
import 'package:destiny_mobile_app/supplier/upload_laptop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:destiny_mobile_app/components/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AppSignIn.dart';
import 'package:flutter/cupertino.dart';
import 'FAQ.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.user}) : super(key: key);

  final FirebaseUser user;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>

    with SingleTickerProviderStateMixin {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message ${message}');
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        displayNotification(message);
        // _showItemDialog(message);
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
  }

  Future displayNotification(Map<String, dynamic> message) async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',);
  }
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Fluttertoast.showToast(
        msg: "Notification Clicked",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Fluttertoast.showToast(
                  msg: "Notification Clicked",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
          ),
        ],
      ),
    );
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
            children: <Widget>[
              _createDrawerHeader(),
              _createDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      )),
              _createDrawerItem(
                  icon: FontAwesomeIcons.user,
                  text: 'Sign In',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppSignIn()),
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
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactUs()),
                      )),
              _createDrawerItem(
                  icon: Icons.settings,
                  text: 'text address',
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadLaptops()),
                      )),
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppSignIn()));
            },
            icon: Icon(FontAwesomeIcons.user),
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
              width: MediaQuery.of(context).size.width,
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
                labelStyle: TextStyle(fontSize: 17.0),
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
                                            builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                                  builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                      stream: Firestore.instance.collection("Destiny").where('product_status', isEqualTo: "available").where('product', isEqualTo: "Laptops").orderBy('timestamp',descending: true).snapshots(),
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
                                          builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                                builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                          builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                                builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                          builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                                builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                              builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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
                                                    builder: (context) => ProductDetails(passed: snapshot.data.documents[index]),
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