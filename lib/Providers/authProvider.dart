// Created By JLA 2019/11/22/time:19:31

import 'package:flutter/cupertino.dart';
import 'package:idonate/Models/user.dart';
import 'package:idonate/data/auth_data.dart';

class AuthP extends ChangeNotifier {
  String uid;
  User user;

  signIn(String email, String password) async {
    uid = await AuthData.signIn(email, password);
  }

  signOut() {}

  createAccount(String email, String password) {}

  checkStatus() async {
    uid = await AuthData.checkStatus();
  }
}
