import 'package:new_take/models/contacts.dart';
import 'package:new_take/screens/add_contact.dart';
import 'package:new_take/screens/contact_detail.dart';
import 'package:new_take/screens/contact_list.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomeScreen(),
      routes: {
        AddContact.routName: (context) => const AddContact(),
        ContactList.routname: (context) => ContactList(),
        // routes to control pages and how to navigate between screens
      },
    );
  }
}
