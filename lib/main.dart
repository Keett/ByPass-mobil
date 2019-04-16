import 'package:bypassmobil/ui/log_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByPassApp());

class ByPassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, backgroundColor: Colors.white),
      home: 
      LogInPage(),
    );
  }
}