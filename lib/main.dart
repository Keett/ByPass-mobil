
import 'package:bypassmobil/login.dart';
import 'package:bypassmobil/page1.dart';
import 'package:bypassmobil/register.dart';
import 'package:bypassmobil/ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByPassApp());

class ByPassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, backgroundColor: Colors.white),
      home: Login(),
      
    );
  }
}