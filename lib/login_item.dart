import 'dart:convert';
class LogInItem{
  int id;
  String ad_soyad;
  String e_mail;
  String sifre;
  bool access;
  bool not_access;

  LogInItem({this.id,this.ad_soyad,this.e_mail,this.sifre,this.access,this.not_access});

  //mapten gelen json dosyasını objeye çevir

  factory LogInItem.fromJson(Map<String,dynamic> map){
    return LogInItem(
      id: map['id'],
      ad_soyad: map['ad_soyad'],
      e_mail: map['e_mail'],
      sifre:map ['sifre'],
      access: map['access'],
      not_access: map['not_access']
    );
  }

  //objeyi json verisine çevir
  String toJson(){
    var map= Map<String,dynamic>();
    map['ad_soyad']=ad_soyad;
    map['e_mail']=e_mail;
    map['sifre']= sifre;
    map['access']=access;
    map['not_access']=not_access;
    return json.encode(map);
  }

}