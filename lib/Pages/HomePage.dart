import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:idonate/Pages/MainHomePage.dart';
import 'package:idonate/Pages/ProfilePage.dart';
import 'package:idonate/Pages/SettingPage.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  final _pageOption =[

    MainHomePage(),
    ProfilePage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageOption[_selectedPage],
        appBar: AppBar(
          title: new Text("I Donate",
              style: TextStyle(fontFamily: "Poppins-Bold")),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.person, title: "Profile"),
            TabData(iconData: Icons.settings, title: "Setting")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedPage = position;
            });
          },
        ));
  }
}