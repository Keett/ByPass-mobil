import 'package:flutter/material.dart';

class Page1 extends StatefulWidget{
  Page1State createState()=> Page1State();
  }
  
  class Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blue,
        title: Text("page1"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
            },
          )
        ],
    ),
    );
  }
}