import 'package:new_take/db/database_helper.dart';
import 'package:new_take/models/contacts.dart';
import 'package:new_take/screens/contact_detail.dart';
import 'package:flutter/material.dart';

/* contact list - it displays contacts from the database
 in a form of a future builder it receives a list*/
class ContactList extends StatefulWidget {
  ContactList({
    Key? key,
  }) : super(key: key);
  static const routname = '/contact-list';

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: FutureBuilder<List<Contacts>>(
          future: DatabaseHelper.instance.getAllContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                /*future builder - handle multiple cases regarding data example
                 if the data is still loading it can show one thing
                  and another thing if there is an error
                   or the data itself if it's loaded without a problem */
                return const Center(
                  child: Text('No data saved yet'),
                );
              } else {
                List<Contacts> contacts = snapshot.data!;

                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Contacts',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        /*
                        listview.builder - create contact cards from
                         the list we received from the database
                         it will show the contacts if the list isn't empty 
                         and will show a message if the list is empty
                         */
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          Contacts contact = contacts[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color.fromARGB(255, 246, 220, 185),
                            margin: const EdgeInsets.all(5),
                            child: ListTile(
                              onTap: () async {
                                var result = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ContactDetail(
                                    ctx: contact,
                                  );
                                }));

                                if (result == 'done') {
                                  setState(() {});
                                }
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                child: Text(
                                  contact.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(contact.name),
                              subtitle: Text(contact.number.toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
