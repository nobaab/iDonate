import 'package:flutter/material.dart';
import 'package:idonate/Users/login.dart';
import 'package:idonate/data/auth_data.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
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
            title: Text(
              'Edit Profile',
              style: TextStyle(fontFamily: "Poppins-Medium"),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              AuthData.auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            leading: Icon(LineAwesomeIcons.sign_out),
            title: Text(
              'Sign Out',
              style: TextStyle(fontFamily: "Poppins-Medium"),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
