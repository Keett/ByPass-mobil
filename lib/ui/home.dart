import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _HomePage createState()=> _HomePage();
  }
  
  class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blue,
        title: Text("ANASAYFA"),
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