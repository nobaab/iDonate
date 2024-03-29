import 'dart:async';
import 'dart:io';

import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idonate/Providers/authProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class NewFund extends StatefulWidget {

  @override
  _NewFundState createState() => _NewFundState();
}

class _NewFundState extends State<NewFund> {
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final GlobalKey<FormState> _fundFormKey = GlobalKey<FormState>();

  String userID, postName, postDetails, postImgUrl,userName;
  String filepath = '${DateTime.now()}.png';
  File _imageFile;
  StorageUploadTask _uploadTask;

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://i-donate-402dd.appspot.com');

  getUserName(userName){
    userName=userName;
  }
  getUserUid(userId) {
    this.userID = userID;
  }

  getPostName(postName) {
    this.postName = postName;
  }

  getTaskDetails(postDetails) {
    this.postDetails = postDetails;
  }

  getImageUrl(postImgUrl) {
    this.postImgUrl = postImgUrl;
  }

  int _myPostType = 0;
  String postVal;

  void _handleTaskType(int value) {
    setState(() {
      _myPostType = value;
      switch (_myPostType) {
        case 1:
          postVal = 'Food';
          break;
        case 2:
          postVal = 'Health';
          break;
        case 3:
          postVal = 'Money';
          break;
        case 4:
          postVal = 'Clothes';
          break;
        case 5:
          postVal = 'Education';
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
    String postDate = dateFormat.format(DateTime.now());
    var authP = Provider.of<AuthP>(context);
    var uid = authP.uid;


    DocumentReference ds =
        Firestore.instance.collection('posts').document(postName);
    Map<String, dynamic> posts = {
      "userID": uid,
      "postName": postName,
      "postDetails": postDetails,
      "postCat": postVal,
      "addTime": postDate,
    };
    setState(() {
      _saveImage();
    });

    // ignore: unnecessary_statements
    ds.setData(posts).whenComplete(() {
      AchievementView(context,
          title: "Yes",
          subTitle: 'Post Successfully Done',
          icon: Icon(
            Icons.insert_emoticon,
            color: Colors.white,
          ), listener: (status) {
        print(status);
      })
        ..show();
    });
  }

  Future<String> _saveImage() async {
    _uploadTask = _storage.ref().child(filepath).putFile(_imageFile);
    postImgUrl = await (await _uploadTask.onComplete).ref.getDownloadURL();
//docUrl is your url as a string
    Firestore.instance
        .collection('posts')
        .document(postName)
        .updateData({"postImgUrl": postImgUrl});

    print(postImgUrl);
    return postImgUrl;
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
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
                                getPostName(name);
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
                              onChanged: (String postDetails) {
                                getTaskDetails(postDetails);
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
                                      'Money',
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
                    RaisedButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Text('Upload Document'),
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
