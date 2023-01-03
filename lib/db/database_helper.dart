import 'dart:io';

import 'package:new_take/models/contacts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// file that helps and handles all the database work
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

// Db creation
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/contacts.db';

    var contactDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return contactDatabase;
  }

//specify what will happen when it's created
//runs only the first time the db is created
  void _createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE tbl_contact(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      number INTEGER NOT NULL,
      email TEXT NOT NULL
    )
''');
  }

  // function to save contacts
  Future<int> saveContact(Contacts contacts) async {
    Database db = await instance.database;
    // int result=await db.rawInsert('INSERT INTO tbl_contact(name,number,email)VALUES(${contacts.name},${contacts.number},${contacts.email})');
    int result = await db.insert('tbl_contact', contacts.toMap());
    return result;
  }
  // function to delete contacts it requires the ID of the contact to delete

  Future<int> deleteContact(Contacts contacts) async {
    Database db = await instance.database;
    int result =
        await db.delete('tbl_contact', where: 'id=?', whereArgs: [contacts.id]);
    return result;
  }

  // function to update contacts it requires the ID of the contact to update
  Future<int> updateContact(Contacts contacts) async {
    Database db = await instance.database;
    int result = await db.update('tbl_contact', contacts.toMap(),
        where: 'id=?', whereArgs: [contacts.id]);
    return result;
  }

  Future<List<Contacts>> getAllContacts() async {
    List<Contacts> contacts = [];

    Database db = await instance.database;
    // function to make the db query
    List<Map<String, dynamic>> mapValues = await db.query('tbl_contact');

    for (var contactMap in mapValues) {
      Contacts contact = Contacts.fromMap(contactMap);
      contacts.add(contact);
    }

    await Future.delayed(Duration(seconds: 1));

    return contacts;
  }
}
