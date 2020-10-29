import 'package:destiny_mobile_app/clients/my_orders.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications extends StatefulWidget {
  PushNotifications({Key key, this.passed}): super(key: key);

  final passed;

  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {

  String _message = '';
  final FirebaseMessaging _fcm = FirebaseMessaging();

  register(){
    _fcm.getToken().then((token) => print(token));
  }

  @override
  void initState(){
    super.initState();
    getMessage();
  }

  void getMessage(){
    _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          setState(() => _message = message['notification']['title']);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          setState(() => _message = message['notification']['title']);
        },
        onResume: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          setState(() => _message = message['notification']['title']);
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanks for Order'),
        backgroundColor: Colors.red[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginHomePage())),
          color: Colors.white,
        ),
      ),
      body:  new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle,color: Colors.green,size: 100,),
            SizedBox(height: 5,),
            Text('Thank You!',style: TextStyle(fontSize: 22,color: Colors.green),),
            SizedBox(height: 5,),
            Text('Your Order has been successfully received and \n will be processed as soon as possible.',style: TextStyle(fontSize: 15,color: Colors.red[700]),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Continue Shopping',style: TextStyle(color: Colors.white),),
                    color: Colors.green,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginHomePage()));
                    }
                    ),
                SizedBox(width: 20,),
                RaisedButton(
                  child: Text('View My Orders',style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrders()));
                    },
                ),
              ],
            )
          ],
    )),
    );
  }
}
