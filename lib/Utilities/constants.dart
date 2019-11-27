import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

final userRef = _firestore.collection('users');
final userPosts = _firestore.collection('posts');
final userHealth = _firestore.collection('posts').document('Health');
final userEducation = _firestore.collection('posts').document('Education');
final userTreatment = _firestore.collection('posts').document('Treatment');
final userFood = _firestore.collection('posts').document('Food');
final userCloth = _firestore.collection('posts').document('Clothes');

class MainFields {
  static const String users = "users";
  static const String posts = "posts";
  static const String Health = "Health";
  static const String Education = "Education";
  static const String Treatment = "Treatment";
  static const String Food = "Food";
  static const String Clothes = "Cloths";
}
