import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idonate/Models/user.dart';
import 'package:idonate/Pages/HomePage.dart';

class SignupUser extends StatefulWidget {

  final UserStore user;

  SignupUser({this.user});

  @override
  _SignupUserState createState() => new _SignupUserState();
}

class _SignupUserState extends State<SignupUser> {

  String userName, userEmail;


  getUserName(userName) {
    userName = userName;
  }

  getUserEmail(userEmail) {
    userEmail = userEmail;
  }


  final GlobalKey<FormState> _userRegFormKey = GlobalKey<FormState>();

  TextEditingController userFullNameController;
  TextEditingController userEmailController;
  TextEditingController userPasswordController;
  TextEditingController userPhoneController;
  TextEditingController userAgeController;

  @override
  void initState() {
    userFullNameController = new TextEditingController();
    userEmailController = new TextEditingController();
    userPasswordController = new TextEditingController();
    userPhoneController = new TextEditingController();
    userAgeController = new TextEditingController();
    super.initState();
  }


  String userEmailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String userPasswordValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }


  void userSignupConfirm() {
    if (_userRegFormKey.currentState.validate()) {
      if (userPasswordController.text != null) {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: userEmailController.text,
            password: userPasswordController.text)
            .then((currentUser) =>
            Firestore.instance
                .collection("users")
                .document(currentUser.user.uid)
                .setData({
              "uid": currentUser.user.uid,
              "name": userFullNameController.text,
              "email": userEmailController.text,
              "phone": userPhoneController.text,
            })
                .then((result) =>
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (_) => false),
              userFullNameController.clear(),
              userEmailController.clear(),
              userPasswordController.clear(),
              userPhoneController.clear(),
            })
                .catchError((err) => print(err)))
            .catchError((err) => print(err));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("The passwords do not match"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Widget radioButton(bool isSelected) =>
      Container(
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

  Widget horizontalLine() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Form(
      key: _userRegFormKey,
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
                            Text("Registration",
                                style: TextStyle(
                                    fontSize:
                                    ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Name",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                    ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Jhon Smith",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: userFullNameController,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                    ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "jhon@yourdomain.com",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: userEmailController,
                              validator: userEmailValidator,
                            ),


                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Phone Number",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                    ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "+88012",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: userPhoneController,
                            ),

                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Password",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                    ScreenUtil.getInstance().setSp(26))),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "password",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: userPasswordController,
                              validator: userPasswordValidator,
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
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
                                  userSignupConfirm();
                                },
                                child: Center(
                                  child: Text("SIGNUP",
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
