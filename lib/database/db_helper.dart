import 'dart:async';


import 'package:flutter_app/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{
  static Database _db;  //Değişken önüne alt çizgi konulduğunda değişken private olur.

  Future<Database> get db async{  //_db'nin getter methodunu oluşturduk.
    if(_db != null)
      return _db;
    _db=await initDb();
    return _db;
  }

  initDb() async { //asenkron methot oluşturmuş olduk
    var dbFolder = await getDatabasesPath();
    String path = join (dbFolder, "Contact.db"); //yeni bi yol oluştur path değişkenine at
    return await openDatabase(path, onCreate: _onCreate,  version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Contact(id INTEGER PRIMARY KEY ,name TEXT, phone_number TEXT, avatar TEXT)");
  }

  Future<List<Contact>> getContacts()async{
    var dbClient = await db;
    var result= await dbClient.query("Contact", orderBy: "name");
    return result.map((data)=> Contact.fromMap(data)).toList(); //dönen result map türüne döndürüldü
  }

  Future<int> insertContact(Contact context) async{
    var dbClient= await db;
    return await dbClient.insert("Contact", context.toMap());

  }

  Future<int> updateContact(Contact contact) async{
    var dbClient =await db;
    return await dbClient.update("Contact", contact.toMap(), where: "id=?", whereArgs:[contact.id] );
  }

  Future<void> removeContact(int id) async{
    var dbClient= await db;
    return await dbClient.delete("Contact", where: "id=?", whereArgs: [id]);
  }


}

