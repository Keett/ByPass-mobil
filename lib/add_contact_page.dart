import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/db_helper.dart';
import 'package:flutter_app/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatelessWidget{
  final Contact contact;
  const AddContactPage({Key key, @required this.contact}) : super(key: key);
//@required : zorunlu tanımlama yapılmak istendiğinde

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.id == null ? "Yeni bağlantı ekle": contact.name),
      ),
      body: SingleChildScrollView(child: ContactForm(contact: contact , child: AddContactForm())),

      //singlechildscrollview bize aşağıdan klavye geldiğinde yukarıdaki sistemi kaydırabilir bi hale
      //getiriyor. bunu yapmadığımızda hata alıyoruz gelen klavye butonun üstüne denk geldiği için
    );
  }
}

//widgetlar arası değişkenleri dataları ortak kullanabilmeyi sağlar InheritedWidget
class ContactForm extends InheritedWidget{
  final Contact contact;
  ContactForm({Key key, @required Widget child, @required this.contact}): super(key:key, child : child);

  //gelen contexti ContactForm olarak geri döndürülüyor..
  static ContactForm of (BuildContext context){
    return context.inheritFromWidgetOfExactType(ContactForm);
  }

  @override
  bool updateShouldNotify(ContactForm oldWidget) {
    return contact.id != oldWidget.contact.id;

  }
}


class AddContactForm extends StatefulWidget{
  @override
  _AddContactFormState createState() => _AddContactFormState();

}

class _AddContactFormState extends State<AddContactForm>{
  final _formKey= GlobalKey<FormState>();
  File _file;
  DbHelper _dbHelper;

  @override
  void initState(){
    _dbHelper=DbHelper();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Contact contact= ContactForm.of(context).contact;

    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            contact.avatar==null ?"assets/images.jpg" : contact.avatar,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
          ),
          Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Colors.blueAccent,
                  onPressed: getFile,
                  )
          )

        ]),

      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "İsim giriniz..",),
                initialValue: contact.name,
                validator: (value){
                  if(value.isEmpty){
                    return "isim girilmesi gerekmektedir...";
                  }
                },
                onSaved: (value) {
                  contact.name = value;
                }

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: "numara giriniz.."),
                  initialValue: contact.phoneNumber,
                  onSaved: (value) {
                    contact.phoneNumber = value;
                  }
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(" Submit"),
              onPressed: ()async{
                if( _formKey.currentState.validate()){
                  _formKey.currentState.save();

                  if(contact.id == null){
                    await _dbHelper.insertContact(contact);
                  }
                  else{
                    await _dbHelper.updateContact(contact);
                  }

                //SnacBar uyarı mesajı yazılmasını sağlar...
                var snackBar = Scaffold.of(context).showSnackBar(
                    SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text("${contact.name} başarıyla eklendi")
                    ),
                );
                //kayıt işlemiş başarılı olduktan sonra ana sayfaya geri dönmesi için;
                snackBar.closed.then((onValue){
                  Navigator.pop(context);
                });
             }
            },),
          ],
        ),),
      ),
    ]
    );
  }

  void getFile() async {
    //contact'a ulaşmak için
    Contact contact= ContactForm.of(context).contact;

    var image = await ImagePicker.pickImage(source: ImageSource.camera); //kameradan görüntü almak için

    setState(() {
      contact.avatar=image.path;
    });

  }
}