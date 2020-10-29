import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destiny_mobile_app/clients/signedin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class UploadScreens extends StatefulWidget {
  @override
  _UploadScreensState createState() => _UploadScreensState();
}

class _UploadScreensState extends State<UploadScreens> {

  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _productbrand = '';
  String _productstatus = '';
  String _storagecapacity = '';
  String _producttype = '';
  String _color = '';
  String _productsize = '';
  String _price = '';
  String _productdescription = '';
  String productOwner='';

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

  final _picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  PickedFile image;
  String _imageName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Screens'),
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
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text('Add Your Product',style: TextStyle(fontSize: 20.0),),
                        ),
                        SizedBox(
                          height: 28,
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
                                onSaved: (value) => _productbrand = value,
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
                                  hintText: "Product Brand",
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
                                onSaved: (value) => _productstatus = value,
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
                                  hintText: "Product Status",
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
                                onSaved: (value) => _storagecapacity = value,
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
                                  hintText: "Storage Capacity",
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
                                onSaved: (value) => _producttype = value,
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
                                  hintText: "Product Type",
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
                                onSaved: (value) => _color = value,
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
                                  hintText: "Color",
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
                                onSaved: (value) => _productsize = value,
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
                                  hintText: "Product Size",
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
                                onSaved: (value) => _price = value,
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
                                  hintText: "Price",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: RaisedButton.icon(
                                onPressed: _showaddphoto,
                                icon: Icon(Icons.file_upload),
                                label: Text('Upload Photo'),
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
                          onSaved: (value) => _productdescription = value,
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
                            hintText: "Product Description",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.all(19.0),
                            onPressed: submit,
                            child: Text(
                              "Upload Product",
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

  void _showaddphoto(){
    AlertDialog dialog = new AlertDialog(
      actions: <Widget>[
        new Text('Choose Your Photo'),
        new IconButton(icon: new Icon(Icons.sd_storage), onPressed:() => uploadFile(),tooltip: 'Take a photo',),
        new IconButton(icon: new Icon(Icons.camera_alt), onPressed:  () => CameraImage(),tooltip: 'Pick From Phone Storage',),
      ],
    );
    showDialog(context: context,child: dialog);
  }

  uploadFile() async{
    image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = image;
    });

  }

  CameraImage() async{
    image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      image = image;
    });

  }


  void submit() async {
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        var file = File(image.path);
        print(file);

        var image_names = file.path.split('/').last;

        if (image != null){


          var snapshot = await _storage.ref().child("Screens/$image_names").putFile(file).onComplete;

          _imageName = await snapshot.ref.getName();

          var productReference = DateTime.now().toUtc().millisecondsSinceEpoch;

          Firestore.instance.collection("Destiny").document('$productReference').
          setData({'product_brand':_productbrand,'picture':_imageName,'product_status':_productstatus,'price':_price,
            'product_storage':_storagecapacity,'product_type':_producttype,'product_id':'$productReference',
            'product_category':'Screens','product':'Accessories','timestamp':DateTime.now().toUtc().millisecondsSinceEpoch,
            'product_color':_color,'product_size':_productsize,'product_description':_productdescription,'product_owner':emailData,
            'stores':'Shamson Technologies','bought_by':''});
          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreens()));
          Fluttertoast.showToast(
            msg: "You Added a New Product",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red[700],
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
          );

        }else{
          print("No path received");
        }
      }catch(e){
        print("error occured now");
      }
    }
  }
}

