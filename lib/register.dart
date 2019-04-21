import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getAPI{
  String error, message;

  getAPI(this.error,this.message);
}

class register extends StatefulWidget{
  @override
  registerState createState() => registerState(); 
}

class registerState extends State<register>{
  TextEditingController adSoyadController=new TextEditingController();
  TextEditingController eMailController=new TextEditingController();
  TextEditingController sifreController=new TextEditingController();
  TextEditingController sifreTekrarController=new TextEditingController();

  String ad_soyad, e_mail, sifre, sifre_tekrar;
  var veri;

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("kayıt ol/register page"),
    ),
    body: Padding(padding: EdgeInsets.all(20.0),
    child: Form(
      child: ListView(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            controller: adSoyadController,
            decoration: InputDecoration(
              icon: const Icon(Icons.person_add),
              labelText: 'Ad Soyad',
              hintText: 'Kübra Elif TOZKOPARAN'
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: eMailController,
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              labelText: 'E-mail',
              hintText: 'ket@example.com'
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: sifreController,
            obscureText: true,
            decoration:InputDecoration(
              icon: const Icon(Icons.lock),
              labelText:'Şİfre' ,
              hintText: '********'
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: sifreTekrarController,
            obscureText: true,
            decoration:InputDecoration(
              icon: const Icon(Icons.lock),
              labelText:'Şİfre Tekrar' ,
              hintText: '********'
            ),
          ),
          Padding(padding: const EdgeInsets.all(20.0),),
          RaisedButton(
            child: Text("KAYIT OL", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            onPressed: (){
              _showDialog("KAYIT OL");
            },
          ),
          RaisedButton(
            child: Text("POST", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            onPressed: post,
          ),
        ],
      ),
    ),
    ),
    );
  }

  void _showDialog(String dialog){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("KAYIT"),
          content: Text(dialog),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  butonbasildi(){
    http.get("http://bypass-web.herokuapp.com/API?user_id=1").then((cevap){
      print(cevap.statusCode);  print(cevap.body.length);
      veri = cevap.body;  print(veri);
    });
    print("buton basıldı");
  }

  post(){
    http.post("http://bypass-web.herokuapp.com/API/index.php", body: {
      "adSoyad" : adSoyadController.text,
      "eMail": eMailController.text,
      "sifre": sifreController.text
    }).then((cevap){
      var jsonData = json.decode(cevap.body);
      print(jsonData["hata"]);  print(jsonData["mesaj"]);
      bool error= jsonData["hata"];
      if(error){
        _showDialog("işlem başarısız");
      }else{
        _showDialog("işlem başarılı");
      }
    });
    print("post basıldı");
  }

}
  

