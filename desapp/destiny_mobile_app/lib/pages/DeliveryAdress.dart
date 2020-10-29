import 'package:destiny_mobile_app/components/push_notifications.dart';
import 'package:destiny_mobile_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:destiny_mobile_app/components/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';

class DeliveryAdress extends StatefulWidget {
  DeliveryAdress({Key key, this.pass}): super(key: key);

  final pass;


  @override
  _DeliveryAdressState createState() => _DeliveryAdressState();
}

class _DeliveryAdressState extends State<DeliveryAdress> {

  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 16;
  double defaultIconSize = 19;

  String _email = '';
  String _village = '';
  String _district = '';
  String _password = '';
  String _phoneNumber = '';

  FirebaseUser user;

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
                      builder: (context) => HomePage()));
            },
            icon: Icon(FontAwesomeIcons.home),
            color: Colors.white,
          ),
        ],
      ),
        body: Container(
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
                    TextFormField(
                      validator: (value){
                        if (value.isEmpty || value.length<10)
                        {
                          return 'input required';
                        }
                        return null;
                      },
                      onSaved: (value) => _phoneNumber = value,
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if (value.isEmpty)
                        {
                          return 'input required';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value,
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
                    Text(
                      'Create an account inorder to complete your order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value){
                        if (value.isEmpty || value.length<6)
                        {
                          return 'input required';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value,
                      showCursor: true,
                      obscureText: true,
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
                          Icons.lock_outline,
                          color: Colors.redAccent,
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Password",
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
                                Text("aaaa",style: TextStyle(color: Colors.red[100]),)
                              ],
                            ),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 10.0)),
                                Text('    ${widget.pass['product_category']}' '\n${widget.pass['product_brand']} \n'
                                    '@ UGX ${widget.pass['price']} \n'
                                    ' will be delivered \n'
                                    'at the address \n'
                                    'you provided',style: TextStyle(color: Colors.red,fontSize: 18)),
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
        ),
    );
  }
  void completeOrder() async{
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        setState(()=> loading = true);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Firestore.instance.collection("Destiny").document("users").collection("user_accounts").document(user.uid).
        setData({'First_name':"firstName",'Last_name':"lastName",'Email':_email,'User_role':'buyer','Contact':_phoneNumber,'Location':'','Image':''}).
        then((value) async{
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email);
          if(_email != null){
            await prefs.setString('email', _email.toString());
            await prefs.setString('password', _password.toString());
            print('Data saved');
          }else{
            await prefs.setString('email', ' ');
            await prefs.setString('email', '');
            print('No email provided');
          }
          Fluttertoast.showToast(
            msg: "Account Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red[700],
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
          );
        });
        }catch(e){
        setState(() {
          loading = false;
        });
        print(e.toString());
      }
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PushNotifications()));
        //print if the email is sent
      } on MailerException catch (e) {
        print('Message not sent. \n' +
            e.toString()); //print if the email is not sent
        // e.toString() will show why the email is not sending
      }
    }
  }
  void showErrorDialog(){
    showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid Username and Password!',style: TextStyle(color: Colors.red),),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}

