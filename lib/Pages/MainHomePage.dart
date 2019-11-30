import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

Future getPosts() async {
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection('posts').getDocuments();
  return qn.documents;
}


class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: JumpingDotsProgressIndicator(
                  fontSize: 25.0,
                  color: Colors.lightBlueAccent,
                ),
              );
            }
            return SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Image(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/imagemain.jpg"),
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 40,
                    left: 30,
                    right: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Explore",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontFamily: 'Poppins-Bold'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Categories",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontFamily: 'CentraleSansRegular',
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110),
                    height: 300,
                    width: 450,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset("assets/slide1.png"),
                        Image.asset("assets/slide2.png"),
                        Image.asset("assets/slide3.png"),
                        Image.asset("assets/slide3.png"),
                        Image.asset("assets/slide3.png"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 370),
                    height: 400,
                    width: 400,
                    child: ListView.builder(
                        // ignore: missing_return
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad1.png"),
                            title: Text(snapshot.data[index].data['postName'],
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle:
                                Text(snapshot.data[index].data['postDetails'],
                                    style: TextStyle(
                                      fontFamily: "CentraleSansRegular",
                                      fontSize: 15,
                                    )),
                          );
                        }),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
