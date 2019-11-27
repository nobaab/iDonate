import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idonate/Providers/authProvider.dart';
import 'package:provider/provider.dart';

class NewFund extends StatefulWidget {
  NewFund();

  @override
  _NewFundState createState() => _NewFundState();
}

class _NewFundState extends State<NewFund> {
  final GlobalKey<FormState> _fundFormKey = GlobalKey<FormState>();

  String userID, postName, postDetails;

  getUserName(userId) {
    this.userID = userID;
  }

  getTaskName(postName) {
    this.postName = postName;
  }

  getTaskDetails(postDetails) {
    this.postDetails = postDetails;
  }

  int _myPostType = 0;
  String postVal;

  void _handleTaskType(int value) {
    setState(() {
      _myPostType = value;
      switch (_myPostType) {
        case 1:
          postVal = 'food';
          break;
        case 2:
          postVal = 'health';
          break;
        case 3:
          postVal = 'treatment';
          break;
        case 4:
          postVal = 'clothes';
          break;
        case 5:
          postVal = 'education';
          break;
      }
    });
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

  createFund() {
    var authP = Provider.of<AuthP>(context);
    var uid = authP.uid;
    DocumentReference ds =
        Firestore.instance.collection('posts').document(postName);
    Map<String, dynamic> posts = {
      "userID": uid,
      "postName": postName,
      "postDetails": postDetails,
      "postCat": postVal,
    };

    ds.setData(posts).whenComplete(() {
      print("posts updated");
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Form(
      key: _fundFormKey,
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
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
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
                            Text("Title",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(),
                              onChanged: (String name) {
                                getTaskName(name);
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Fund Details",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(),
                              onChanged: (String taskdetails) {
                                getTaskDetails(taskdetails);
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Select Fund Type",
                                style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: _myPostType,
                                      onChanged: _handleTaskType,
                                      activeColor: Color(0xff4158ba),
                                    ),
                                    Text(
                                      'Food',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: _myPostType,
                                      onChanged: _handleTaskType,
                                      activeColor: Color(0xfffb537f),
                                    ),
                                    Text(
                                      'Health',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 3,
                                      groupValue: _myPostType,
                                      onChanged: _handleTaskType,
                                      activeColor: Color(0xff4caf50),
                                    ),
                                    Text(
                                      'Treatment',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 4,
                                      groupValue: _myPostType,
                                      onChanged: _handleTaskType,
                                      activeColor: Color(0xff9962d0),
                                    ),
                                    Text(
                                      'Clothes',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 5,
                                      groupValue: _myPostType,
                                      onChanged: _handleTaskType,
                                      activeColor: Color(0xff0dc8f5),
                                    ),
                                    Text(
                                      'Education',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                  createFund();
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
