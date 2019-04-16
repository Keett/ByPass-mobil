import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget{
  @override
  _LogInPageState createState()=> _LogInPageState();
}

class _LogInPageState extends State<LogInPage>{
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
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
          //key: _form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Ad Soyad"
                  ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Ad-Soyadı girmen lazım...";
                      }  
                    },

                  //onsaved metodu
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
//----->>>>>>>İF KULLANICI KAYITLIYSA
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


                  },
                  ),

            ],
          ),
        ),
        )

      ],
      ),

      )
      
      
    );
  }
}