import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idonate/Catagories/Health_Page.dart';
import 'package:idonate/Catagories/PostDetails.dart';
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
  String postImgUrl;

  getImageUrl(postImgUrl) {
    this.postImgUrl = postImgUrl;
  }

  navigateToDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostDetails(
                  post: post,
                )));
  }

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
                        InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => HealthPage());
                            Navigator.push(context, route);
                          },
                          child: Image.asset("assets/slide3.png"),
                        ),
                        InkWell(
                          child: Image.asset("assets/slide2.png"),
                        ),
                        InkWell(
                          child: Image.asset("assets/slide1.png"),
                        ),
                        InkWell(
                          child: Image.asset("assets/slide2.png"),
                        ),
                        InkWell(
                          child: Image.asset("assets/slide2.png"),
                        ),
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
                          return Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: ListTile(
                              onTap: () =>
                                  navigateToDetails(snapshot.data[index]),
                              trailing: Icon(Icons.more_vert),
                              leading: Image.network(
                                snapshot.data[index].data['postImgUrl'] != null
                                    ? snapshot.data[index].data['postImgUrl']
                                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                width: 80,
                                fit: BoxFit.fitWidth,
                              ),
                              title: Text(snapshot.data[index].data['postName'],
                                  style: TextStyle(
                                      fontFamily: "CentraleSansRegular",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
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
