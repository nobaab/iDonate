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
    return Container(
      child: Card(
        child: ListTile(
          title: Text(widget.post.data["postName"]),
          subtitle: Text(widget.post.data["postDetails"]),
        ),
      ),
    );
  }
}
