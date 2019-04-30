import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class apitest extends StatefulWidget {
  @override
  _apitestState createState() => _apitestState();
}

class _apitestState extends State<apitest> {

  getveriler() async  {
    // controller.addListener(listener)
    var client = new http.Client();
    var url = 'http://bypass-web.herokuapp.com/API/ilac';
    /* var response = await client.post(url,headers: {'Content-type': 'application/x-www-form-urlencoded'}, body: {
      'email': emailConroller.text,
      'parola': parolaConroller.text,
    });*/
    var response = await client.get(
      url, headers: {'Content-type': 'application/x-www-form-urlencoded'},);

     var jsondata = json.decode(response.body);
    print(jsondata);


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Get DATA"),
                onPressed: () {
                  getveriler();
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Get DATA"),
              onPressed: () {
                getveriler();
              },
            ),
          ],
        ),
      ),
    );
  }

}