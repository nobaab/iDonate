import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonate/Providers/authProvider.dart';
import 'package:idonate/Utilities/constants.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

final startColor = Color(0xFFaa7ce4);
final endColor = Color(0xFFe46792);
final titleColor = Color(0xff444444);
final textColor = Color(0xFFa9a9a9);
final shadowColor = Color(0xffe9e9f4);

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authP = Provider.of<AuthP>(context);
    var uid = authP.uid;
    return FutureBuilder(
        future:
            Firestore.instance.collection(MainFields.users).document(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 28.0,
              ),
            );
          return userInfo(snapshot);
        });
  }

  userInfo(AsyncSnapshot<DocumentSnapshot> snapshot) {
    var doc = Map.from(snapshot.data.data);
    return doc != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                doc['name'],
              ),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/ill.png'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.blueAccent.withOpacity(.2), width: 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  doc['name'],
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 20,
                    fontFamily: "Poppins-Bold",
                  ),

                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      child: Divider(
                        height: 1,
                        color: titleColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text("User information",style: TextStyle(
                                fontFamily: "Poppins-Bold",
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Email",style: TextStyle(
                                fontFamily: "Poppins-Medium",
                              ),),
                              subtitle: Text(
                                doc["email"],
                              ),
                              leading: Icon(Icons.mail),
                            ),
                            ListTile(
                              title: Text("Phone",style: TextStyle(
                                fontFamily: "Poppins-Medium",
                              ),),
                              subtitle: Text(
                                doc["phone"],
                              ),
                              leading: Icon(LineAwesomeIcons.phone),
                            ),
                            ListTile(
                              title: Text("User ID",style: TextStyle(
                                fontFamily: "Poppins-Medium",
                              ),),
                              subtitle: Text(
                                doc["uid"],
                              ),
                              leading: Icon(LineAwesomeIcons.sticky_note),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
        : Container(
            child: Center(
              child: Text("Snapshot null"),
            ),
          );
  }
}
