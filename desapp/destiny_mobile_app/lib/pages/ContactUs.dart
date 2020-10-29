import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}


String defaultFontFamily = 'Roboto-Light.ttf';
double defaultFontSize = 14;
double defaultIconSize = 17;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _firstName = '';
String _lastName = '';
String _email = '';
String _message = '';


class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Us'),
        backgroundColor: Colors.red[700],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white70,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text('Get in touch',style: TextStyle(fontSize: 20.0),),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (value){
                                  if (value.isEmpty)
                                  {
                                    return 'input required';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _firstName = value,
                                showCursor: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText: "First Name",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (value){
                                  if (value.isEmpty)
                                  {
                                    return 'input required';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _lastName = value,
                                showCursor: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText: "Last Name",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
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
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF2F3F5),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                  ),
                                  hintText: "Email",
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          validator: (value){
                            if (value.isEmpty)
                            {
                              return 'input required';
                            }
                            return null;
                          },
                          onSaved: (value) => _message = value,
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
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize),
                            hintText: "Message",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: RaisedButton(
                            padding: EdgeInsets.all(17.0),
                            onPressed: submit,
                            child: Text(
                              "Send Message",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins-Medium.ttf',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.red[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red[700])),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  void submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String username = "shamsontechnologies@gmail.com";
      String password = "YY@shamson2020";
      String messages = _message;
      print(_message);
      print("hello");

      final smtpServer = gmail(username, password);
      // Creating the Gmail server

      // Create our email message.
      final message = Message()
        ..from = Address(_email,"${_firstName+" "+_lastName }")
        ..recipients.add('shamsontechnologies@gmail.com') //recipent email
        ..ccRecipients.addAll(['egarufelix@gmail.com', 'shamsontechnologies@gmail.com','mugishasamuel956@gmail.com']) //cc Recipents emails
      // ..bccRecipients.add(Address('egarufelix@gmail.com')) //bcc Recipents emails
        ..subject = 'Customer Inquiry: ${DateTime.now()}' //subject of the email
        ..text = _message; //body of the email
      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' +
            sendReport.toString()); //print if the email is sent
      } on MailerException catch (e) {
        print('Message not sent. \n' +
            e.toString()); //print if the email is not sent
        // e.toString() will show why the email is not sending
      }
    }
  }
}
