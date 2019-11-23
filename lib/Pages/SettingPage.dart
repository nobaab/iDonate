import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idonate/Users/login.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

Future<void> _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e); // TODO: show dialog with error
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(LineAwesomeIcons.user_md),
            title: Text('Edit Profile',style: TextStyle(fontFamily: "Poppins-Medium"),),
          ),
          Divider(),
          ListTile(
            onTap: (){


            },
            leading: Icon(LineAwesomeIcons.sign_out),
            title: Text('Sign Out',style: TextStyle(fontFamily: "Poppins-Medium"),),
          ),
          Divider(),
        ],
      ),
    );
  }
}
