class Contacts {
  int? id;
  late String name;
  late String email;
  late int number;
/*class that contains the contact information,
creating a variable called contacts it will have all the following attributes */
  Contacts({
    this.id,
    required this.name,
    required this.email,
    required this.number,
  });

/* two functions to get contacts from and to the database/
 Use maps when dealing with databases in most cases*/
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'number': number,
    };
  }

  Contacts.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    number = map['number'];
  }
}
