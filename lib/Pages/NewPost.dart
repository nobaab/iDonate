import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idonate/Pages/HomePage.dart';
import 'package:idonate/Utilities/constants.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => new _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var selectedCatagory;
  final GlobalKey<FormState> _newPostFormKey = GlobalKey<FormState>();

  TextEditingController newPostTitleController;
  TextEditingController newPostDescController;

  @override
  void initState() {
    newPostTitleController = new TextEditingController();
    newPostDescController = new TextEditingController();
    super.initState();
  }

  void submiAndSavePost() {
    // ignore: unrelated_type_equality_checks
    if (newPostTitleController.text.isNotEmpty &&
        newPostDescController.text.isNotEmpty) {
      Firestore.instance
          .collection("catagories")
          .document().collection("posts")
          .add({
            "title": newPostDescController.text,
            "description": newPostDescController.text
          })
          .then((result) => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ))
              })
          .catchError((err) => print(err));
    }
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Form(
      key: _newPostFormKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/imagemain.jpg"),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset("assets/image_02.png")
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/logo.png",
                          width: ScreenUtil.getInstance().setWidth(110),
                          height: ScreenUtil.getInstance().setHeight(110),
                        ),
                        Text("LOGO",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(46),
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil.getInstance().setHeight(850),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Raise Fund",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Fund Title",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Fund Title",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: newPostTitleController,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Fund Descrption",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Description",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: newPostDescController,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection("catagories")
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                      child: JumpingDotsProgressIndicator(
                                        fontSize: 25.0,
                                      ),
                                    );
                                  else {
                                    List<DropdownMenuItem> catagoriesItems = [];
                                    for (int i = 0;
                                        i < snapshot.data.documents.length;
                                        i++) {
                                      DocumentSnapshot snap =
                                          snapshot.data.documents[i];
                                      catagoriesItems.add(
                                        DropdownMenuItem(
                                          child: Text(
                                            snap.documentID,
                                            style: TextStyle(
                                                fontFamily: "Poppins-Medium"),
                                          ),
                                          value: "${snap.documentID}",
                                        ),
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          LineAwesomeIcons.certificate,
                                          size: 25.0,
                                        ),
                                        SizedBox(width: 10),
                                        DropdownButton(
                                          items: catagoriesItems,
                                          onChanged: (catagoryValue) {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                'Selected PostType value is $catagoryValue',
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Medium"),
                                              ),
                                            );
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                            setState(() {
                                              selectedCatagory = catagoryValue;
                                            });
                                          },
                                          value: selectedCatagory,
                                          isExpanded: false,
                                          hint: new Text(
                                            "Choose Post Type",
                                            style: TextStyle(
                                                fontFamily: "Poppins-Medium"),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Text("Upload Doc",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  submiAndSavePost();
                                },
                                child: Center(
                                  child: Text("Raise",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
