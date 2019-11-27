import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;

  User({this.id, this.name});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
    );
  }
}
