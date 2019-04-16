import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget{
  @override
  _LogInPageState createState() => _LogInPageState();

  }
  
  class _LogInPageState extends State<LogInPage> {
    final _formKey=GlobalKey<FormState>();
    String _adSoyad, _eMail, _sifre;


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
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
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

                Padding(
                  padding: const EdgeInsets.all(10),
                ),


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

                  Padding(
                    padding: const EdgeInsets.all(50),
                  ),

                  RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text("Kaydet"),
                    onPressed: ()async{
                      //kayıt başarılı
                      _formKey.currentState.save();
                      if(_formKey.currentState.validate()){
                        Navigator.pop(context,_adSoyad);
                        Navigator.pop(context,_eMail);
                        Navigator.pop(context,_sifre);
                        Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Tebrikler başarıyla kayıt olundu.."),
                      ));
                      }
                      else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Bu hesaba kayıtlı bir kullanıcı mevcut.Giriş yapmak ister misiniz?"),
                        action: SnackBarAction(
                          label: "GİRİŞ YAP",
                          onPressed: ()async{

                            //durum değiştiğinde sayfa güncelleme methodu
                            setState(() { });
                          },
                        ),
                      ));
                      }
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(30),
                  ),

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