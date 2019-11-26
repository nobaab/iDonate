import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonate/Providers/authProvider.dart';
import 'package:idonate/Utilities/constants.dart';
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
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/ill.png'), fit: BoxFit.fill),
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    doc['email'],
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 12,
                    child: VerticalDivider(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '934 Feedback',
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                width: 320,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 30,
                          spreadRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'website',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'www.google.com',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.headset,
                                      size: 15,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(
                                      Icons.headset,
                                      size: 15,
                                    ),
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      'Biography',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                        'Contrary to popular belief, Lorem Ipsum is not simply random text It has roots in a piece of classical Latin literature from 45 BC')
                  ],
                ),
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
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        : Container(
            child: Center(
              child: Text("Snapshot null"),
            ),
          );
  }
}
