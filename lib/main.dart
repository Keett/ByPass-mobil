import 'package:flutter/material.dart';
import 'package:flutter_app/add_contact_page.dart';
import 'package:flutter_app/contact_page.dart';
import 'package:flutter_app/model/contact.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
        home: ContactPage()
    );
  }
}
