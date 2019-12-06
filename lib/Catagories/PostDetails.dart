import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PostDetails extends StatefulWidget {
  final DocumentSnapshot post;
  PostDetails({this.post});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.data["postName"]),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Image.network(
                widget.post.data["postImgUrl"] != null
                    ? widget.post.data["postImgUrl"]
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 24),

              Text(
               widget.post.data["postCat"],
                style: TextStyle(
                  fontFamily: "Poppins-Bold",
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 24),

              Card(
                child: ListTile(
                  title: Text(
                    widget.post.data["postName"],
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    widget.post.data["postDetails"],
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 15,
                    ),
                  ),
                ),
              ),


              SizedBox(height: 24),

            ],
          ),
        ),
      ),

    );
  }
}



