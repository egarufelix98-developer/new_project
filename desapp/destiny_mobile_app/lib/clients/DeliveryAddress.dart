import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:destiny_mobile_app/components/push_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:destiny_mobile_app/components/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryAddress extends StatefulWidget {
  DeliveryAddress({Key key, this.pass}): super(key: key);

  final pass;


  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 16;
  double defaultIconSize = 19;

  String _phoneNumber = '';
  String _email = '';
  String _district = '';
  String _village = '';


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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool loading = false;

  final TextStyle textstyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.pass['product_brand']}'),
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
      body: StreamBuilder(
          stream: Firestore.instance.collection("Destiny").document('users').collection('user_accounts').where(
              'Email', isEqualTo: emailData).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            int length = snapshot.data.documents.length;
            print(snapshot.data);
            final DocumentSnapshot doc = snapshot.data
                .documents[0];
            return Container(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(35.0, 30.0, 35.0, 30.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/address.png',height: 60.0,),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Hi ${doc.data['First_name']} ${doc.data['Last_name']},',
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                        Text('Provide Delivery Address',
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                        Text('to complete order',
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value){
                            if (value.isEmpty)
                            {
                              return 'input required';
                            }
                            return null;
                          },
                          onSaved: (value) => _phoneNumber = value,
                          initialValue: '${doc.data['Contact']}',
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.redAccent,
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "Phone Number",
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          validator: (value){
                            if (value.isEmpty)
                            {
                              return 'input required';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value,
                          initialValue: emailData,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.redAccent,
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "Email",
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          validator: (value){
                            if (value.isEmpty)
                            {
                              return 'input required';
                            }
                            return null;
                          },
                          onSaved: (value) => _district = value,
                          initialValue: '${doc.data['Location']}',
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.redAccent,
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "City or District",
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          validator: (value){
                            if (value.isEmpty)
                            {
                              return 'input required';
                            }
                            return null;
                          },
                          onSaved: (value) => _village = value,
                          initialValue: '${doc.data['Location']}',
                          showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "Village or State",
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Card(
                          color: Colors.red[100],
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${widget.pass['product_category']}%2F${widget.pass["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4"' +
                                            '?alt=media',
                                        fit: BoxFit.fill,),
                                      width: 130,
                                      height: 120,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('  ${widget.pass['product_category']}' '\n${widget.pass['product_brand']}',
                                        style: TextStyle(color: Colors.red,fontSize: 18)),
                                    Text(' @ UGX ${widget.pass['price']} ',
                                        style: TextStyle(color: Colors.red,fontSize: 18)),
                                    Text(' will be delivered at the',
                                        style: TextStyle(color: Colors.red,fontSize: 18)),
                                    Text(' address you provided!',
                                        style: TextStyle(color: Colors.red,fontSize: 18)),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Icon(Icons.check_circle,color: Colors.green,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                            color: Colors.red[700],
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadiusDirectional.circular(18.0),
                            ),
                            onPressed: (){
                              completeOrder();
                            },
                            child: Text(
                              'Complete Order',style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
  void completeOrder() async{
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        setState(()=> loading = true);
        String username = "shamsontechnologies@gmail.com";
        String password = "YY@shamson2020";

        final smtpServer = gmail(username, password);
        // Creating the Gmail server

        // Create our email message.
        final message = Message()
          ..from = Address(_email,"$_phoneNumber")
          ..recipients.add('shamsontechnologies@gmail.com') //recipent email
          ..ccRecipients.addAll(['egarufelix@gmail.com', 'shamsontechnologies@gmail.com','mugishasamuel956@gmail.com']) //cc Recipents emails
        // ..bccRecipients.add(Address('egarufelix@gmail.com')) //bcc Recipents emails
          ..subject = 'New Product Order: ${DateTime.now()}'
        // ..attachments.add(await new FileImage(file))//subject of the email
          ..text = '${widget.pass['product_category']}' '\n${widget.pass['product_brand']} \n'
              '@ UGX ${widget.pass['price']} \n$_district \n'
              '$_village\n'
              '$_phoneNumber'; //body of the email
        try {
          final sendReport = await send(message, smtpServer);
          print('Message sent: ' +
              sendReport.toString());
          Firestore.instance.collection("Destiny").document('${widget.pass['product_id']}').updateData({"bought_by":_email,"product_status":"Pending"});
          //print if the email is sent
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PushNotifications()));
        } on MailerException catch (e) {
          print('Message not sent. \n' +
              e.toString()); //print if the email is not sent
          // e.toString() will show why the email is not sending
        }
      }catch(error){
        print(error.toString());
      }

    }
  }
}

