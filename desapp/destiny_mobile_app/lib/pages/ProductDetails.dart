import 'package:destiny_mobile_app/pages/DeliveryAdress.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({this.passed});
  final passed;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(passed['product_brand']),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*Image.network(
              widget.productDetails.data.productVariants[0].productImages[0]),*/
            Image.network( "https://firebasestorage.googleapis.com/v0/b/shamson-958e0.appspot.com/o/${passed["product_category"]}%2F${passed["picture"]}?alt=media&token=774d30c3-a9f8-403c-bbce-0b45ffceabe4",fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress){
              if (loadingProgress == null) return child;
              return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
            },),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("PRODUCT BRAND",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF565656))),
                  Text(passed['product_brand'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFfd0100))),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF999999),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("COLOR",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF565656))),
                  Text(passed['product_color'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFfd0100))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Price".toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF565656))),
                  Text(passed['price'].toString()+" "+"UGX",
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  color: Color(0xFFfd0100))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              color: Color(0xFFFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Description",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF565656))),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                      passed['product_description'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4c4c4c))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                color: Color(0xFFFFFFFF),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Specification",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF565656))),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          // Text("SIZE:"+" "+passed['product_size'] +" "+" "+  "STORAGE:"+" "+passed['product_storage'],style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w500,
                          //     color: Color(0xFF565656))),
                          // Text("STORAGE:"+" "+passed['product_storage'],style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w500,
                          //     color: Color(0xFF565656))),
                        ],
                      )
                    ]
                )
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                color: Color(0xFFFFFFFF),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 70,
                        padding: EdgeInsets.all(5),
                        child: RaisedButton(
                          color: Colors.red[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                          ),
                          onPressed: () {
                            // Firestore.instance.collection("Destiny").where('product_id',isEqualTo: passed['product_id']).getDocuments().
                            // then((value) {
                            //   return value.documents;
                            //   final DocumentSnapshot doc = value.documents[0];
                            // }
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryAdress(pass: passed),
                              ),
                            );
                          },
                          child: Text(
                            'Buy Now',style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                      )
                    ]
                )
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      );
}
}