import 'dart:convert';

import 'package:bypassmobil/eski_dosyalar/login_item.dart';
import 'package:http/http.dart' as http;
class ItemService{
  final String _serviceUrl= 'kesali-shopping.herokuapp.com';

  //öge ekle
  Future<LogInItem> addItem(LogInItem login_item) async{
    var uri=Uri.http(_serviceUrl, "login_item");
    final response = await http.post(uri,headers: {
      'content-type': 'application/json'
      },body: login_item.toJson());

      if(response.statusCode==201){
        Map login_item=json.decode(response.body);
        return LogInItem.fromJson(login_item);
      }else{
        throw Exception('birşeyler yanlış gitti');
      }
  }


}