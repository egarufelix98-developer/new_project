import 'package:destiny_mobile_app/clients/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

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
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("Destiny").where('bought_by', isEqualTo: emailData).orderBy('timestamp',descending: true).snapshots(),
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
                                subtitle: Text("UGX ${doc.data["price"]} \n Still ${doc.data["product_status"]}",
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
    );
  }
}
