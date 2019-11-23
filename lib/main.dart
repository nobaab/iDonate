import 'package:flutter/material.dart';
import 'package:idonate/Pages/HomePage.dart';
import 'package:idonate/Pages/SplashPage.dart';
import 'package:idonate/Providers/authProvider.dart';
import 'package:idonate/Users/login.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<AuthP>.value(value: AuthP()),
      ],
      child: MaterialApp(
        home: AuthDecider(),
      ),

    );
  }
}


class AuthDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authP = Provider.of<AuthP>(context);

    return FutureBuilder(
              future: authP.checkStatus(),
              builder: (context, asyncSnap) {
                switch(asyncSnap.connectionState){
                  case ConnectionState.done:
                    if(authP.uid!=null)
                     return HomePage();
                    else
                     return LoginPage();
                    break;
                  case ConnectionState.none:
                    return Center(
                     child: Text("Network Error, check conenction"),);
                    break;

                  default:
                    return Container();
                    break;
                }
              }
          );
  }
}

