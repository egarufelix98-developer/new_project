import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Text("What is Destiny ?",style: TextStyle(fontSize: 20,color: Colors.red[700]),),
            SizedBox(height: 10,),
            Text("Destiny is an ecommerce mobile app that will enable all users access accessories be it mobile phones, laptops, cameras and all other electronic gadgets at the lowest possible prices"
            ,style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text("Do you make Product Delivery ?",style: TextStyle(fontSize: 20,color: Colors.red[700]),),
            SizedBox(height: 10,),
            Text("We offer free deliveries around Kampala and as well as make product deliveries to our clients in all parts of the country at a friendly cost.",style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text("Where are your offices located ?",style: TextStyle(fontSize: 20,color: Colors.red[700]),),
            SizedBox(height: 10,),
            Text("Our offices are located in Zana along Kampala-Entebbe road opposite Front Page Hotel."
              ,style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text("What kind of products do you sell ?",style: TextStyle(fontSize: 20,color: Colors.red[700]),),
            SizedBox(height: 10,),
            Text("We sell both brand new and second hand accessories depending the clients request or desire.",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
