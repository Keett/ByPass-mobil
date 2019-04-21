import 'dart:convert';

import 'package:bypassmobil/page1.dart';
import 'package:bypassmobil/register.dart';
import 'package:bypassmobil/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Login extends StatefulWidget{
  @override
  loginState createState() => loginState();
}
class loginState extends State<Login>{
  TextEditingController eMailController= new TextEditingController();
  TextEditingController sifreController = new TextEditingController();

  String eMail, sifre; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GİRİŞ"), 
      ),
      //SingleChildScrollView (kaydırma yapmamızı sağlar)
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: eMailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'ket@example.com',
                  labelText: 'E-mail'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: sifreController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  hintText: '***',
                  labelText: 'Şifre'
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20.0),),
              RaisedButton(
                child: Text("LOGIN", style: TextStyle(color: Colors.white),),
                color: Colors.blue,
                onPressed: (){
                  eMail=eMailController.text;
                  sifre=sifreController.text;
                  login(context);
                },
              ),
              Padding(padding: EdgeInsets.only(top: 5.0),),
              RaisedButton(
                child: Text("FORGOT PASSWORD", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Page1()));
                },
              ),
              Padding(padding: EdgeInsets.only(top: 5.0),),
              RaisedButton(
                child: Text("Register(kayıt ol)", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=> new register()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context){
    http.get("http://bypass-web.herokuapp.com/API?email=" + eMail).then((cevap){
      print(cevap.statusCode);  print(cevap.body.length);
      var jsonData = json.decode(cevap.body);
      print(jsonData);  print(jsonData["hata"]);
      bool error = jsonData["hata"];
      if(!error){
        print(jsonData["data"]["sifre"]);
        String a= jsonData["data"]["sifre"];
        if(a == sifre){
          print("home page");
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
        }else{
          _showDialog("e-mail veya şifreyi kontrol edin");
        }
      }else{
        _showDialog("error\nE-mail veya şifreyi kontrol et");
      }
    });
    print("butona basıldı");
  }

  void _showDialog(String dialog){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(title: Text("LOGIN"),
        content: Text(dialog),
        actions: <Widget>[
          FlatButton(child: Text("OK"),
            onPressed: (){
            Navigator.of(context).pop();
            },
          ),
        ],
        );
      },
    );
  }

}
