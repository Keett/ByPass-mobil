import 'package:flutter/material.dart';
import 'package:flutter_app/add_contact_page.dart';
import 'package:flutter_app/database/db_helper.dart';
import 'package:flutter_app/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget{
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>{
  DbHelper _dbhelper;

  @override
  void initState() {
    _dbhelper= DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Soru Sayfası"),
        // appBar'a + ekler    actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        //print(Contact.contacts.length); //liste sayısını console da görmek için 
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(contact: Contact())));
        },
        child: Icon(Icons.add),
      ),

      body: FutureBuilder(
        future: _dbhelper.getContacts(),
        builder: (BuildContext context, AsyncSnapshot <List<Contact>> snapshot) {
          //henüz snapshot da bir data yoksa;
          if(!snapshot.hasData) return CircularProgressIndicator();  //yükleniyor circular'ı göstermek için
          if(snapshot.data.isEmpty) return Text("hiç bir veri eklenmemiştir..");

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = snapshot.data[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContactPage(contact: contact,)));
                },
                  child: Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.delete, color: Colors.white,),
                    ),
                  ),
                  onDismissed: (direction) async{
                    await _dbhelper.removeContact(contact.id);
                    setState(() {});

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${contact.name} silindi"),
                      action: SnackBarAction(
                        label: "GERİ AL",
                        onPressed: ()async{
                          //durum değiştiğinde sayfa güncelleme methodu
                          await _dbhelper.insertContact(contact);
                          setState(() { });
                        },
                      ),
                    ));
                  },

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        contact.avatar==null ? "assets/images.jpg" : contact.avatar,
                      ),
                      child: Text(
                        contact.name[0],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                    trailing: IconButton(icon: Icon(Icons.phone), onPressed: ()async => _callContact(contact.phoneNumber)),
                  ),
              ),
                );
/*
ListTile yerine Container bloğu konulduğunda da aynı işlem yapılıyor sadece listTile daha kısa

            return Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://placekitten.com/200/300",
                        ),
                        child: Text(
                          contact.name[0],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(contact.name),
                            Text(contact.phoneNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ],
              ),
            );
            */
            });
      },),
    );
  }

  _callContact(String phoneNumber) async{
    String tel="tel:$phoneNumber";
    if(await canLaunch(tel)){
      await launch(tel);
    }
  }
}

