import 'package:flutter/material.dart';

class userJson{
  String adSoyad, eMail, sifre;
  userJson(this.adSoyad,this.eMail,this.sifre);
}
class user extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Json"),),
    );
  }
  
}
