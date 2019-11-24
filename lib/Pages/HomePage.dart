import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:idonate/Pages/MainHomePage.dart';
import 'package:idonate/Pages/NewPost.dart';
import 'package:idonate/Pages/ProfilePage.dart';
import 'package:idonate/Pages/SettingPage.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  final _pageOption = [
    MainHomePage(),
    NewPost(),
    ProfilePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageOption[_selectedPage],
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: LineAwesomeIcons.home, title: "Home"),
            TabData(iconData: LineAwesomeIcons.plus, title: "Fund"),
            TabData(iconData: LineAwesomeIcons.user, title: "Profile"),
            TabData(iconData: LineAwesomeIcons.bell, title: "Setting")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedPage = position;
            });
          },
        ));
  }
}
