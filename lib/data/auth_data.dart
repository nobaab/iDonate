// Created By JLA 2019/11/22/time:19:33

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthData {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Firestore st = Firestore.instance;

  static Future<String> signIn(String email, String password) async {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid != null ? result.user.uid : null;
  }

  signOut() {
    auth.signOut();
  }

  createAccount(String email, String password) {
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<String> checkStatus() async {
    FirebaseUser result = await auth.currentUser();
    return result.uid;
  }
}
