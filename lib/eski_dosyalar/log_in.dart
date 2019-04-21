import 'package:bypassmobil/eski_dosyalar/login_item.dart';
import 'package:bypassmobil/http/item_service.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget{
  @override
  _LogInPageState createState() => _LogInPageState();

  }
  
class _LogInPageState extends State<LogInPage> {
  ItemService _itemService;
  final _formKey=GlobalKey<FormState>();
  String _adSoyad,_eMail,_sifre;
  
  @override
  void initState(){
    _itemService= ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("KAYIT OL"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ad Soyad"),
                          onSaved: (value) => _adSoyad=value,
                          autofocus: true,
                          validator: (value){
                            if(value.isEmpty){
                              return "Ad-Soyadı girmen lazım...";
                            }  
                          },
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "E-mail " ),
                          onSaved: (value) => _eMail=value,
                          autofocus: true,
                          validator: (value){
                            if(value.isEmpty){
                              return "E-mail'i girmen lazım...";
                            }
                          },
                        ),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Şifre"),
                          onSaved: (value)=> _sifre=value,
                          autofocus: true,
                          validator: (value){
                            if(value.isEmpty){
                              return "Şifreni girmen lazım";
                            }
                          },
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(50)),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text("Kaydet"),
                      onPressed: ()async{
                        _formKey.currentState.save();
                        if(_formKey.currentState.validate()){
                          Navigator.pop(context, _adSoyad);
                          Navigator.pop(context, _eMail);
                          Navigator.pop(context, _sifre);
                        }

                        String login_adSoyad=await showDialog(context: context);
                        String login_eMail=await showDialog(context: context);
                        String login_sifre=await showDialog(context: context);

                        if(login_adSoyad.isNotEmpty){
                          var login_item=LogInItem(
                            ad_soyad: login_adSoyad,
                            e_mail: login_eMail,
                            sifre: login_sifre
                          );
                          try{
                            await _itemService.addItem(login_item);
                          }catch(ex){
                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(ex.toString())));
                          }
                        }
                      }
                    ),
                    Padding(padding: const EdgeInsets.all(30)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width:5.0),
                          InkWell(
                            onTap: (){},
                            child: Text('Şifremi unuttum',
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                              ),
                            ),
                          )
                        ],
                      ),     
                  ],
                ),
              ),
            ),
          ],
          ),
      ),
    );
  }
    
}