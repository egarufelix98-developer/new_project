import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:destiny_mobile_app/components/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppSignUp extends StatefulWidget {
  @override
  _AppSignUpState createState() => _AppSignUpState();
}

class _AppSignUpState extends State<AppSignUp> {

  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;

  FirebaseUser user;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool loading = false;

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white70,
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      child: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.close),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 130,
                          height: 130,
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/ic_app_icon1.jpg"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                validator: (value){
                                  if (value.isEmpty)
                                  {
                                    return 'Please fill your details';
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
                                    return 'Please fill your details';
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
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty)  {
                              return 'please provide number';
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
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText: "Email",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value.length < 11 )  {
                              return 'please provide a valid phone number';
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
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText: "0700000000",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.length < 6)  {
                              return 'Password must be atleast 6 char long';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
                          obscureText: true,
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
                              Icons.lock_outline,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.all(17.0),
                            onPressed: signUp,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins-Medium.ttf',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.red[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.red[700])),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {
                              Navigator.pop(
                                  context
                              ),
                            },
                            child: Container(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  // void saveData() async{
  //   SharedPreferences.setMockInitialValues({});
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if(_email != null){
  //     await prefs.setString('email', _email.toString());
  //     await prefs.setString('password', _password.toString());
  //     await prefs.setString('displayName', user.displayName);
  //     print('Data saved');
  //   }else{
  //     await prefs.setString('email', ' ');
  //     await prefs.setString('email', '');
  //     print('No email provided');
  //   }
  // }


  void signUp() async {
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        setState(()=> loading = true);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Firestore.instance.collection("Destiny").document("users").collection("user_accounts").document(user.uid).
        setData({'First_name':_firstName,'Last_name':_lastName,'Email':_email,'User_role':'buyer','Contact':_phoneNumber,'Location':'','Image':''}).
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginHomePage()));
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
        return showErrorDialog();
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