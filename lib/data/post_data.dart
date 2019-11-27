import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idonate/Models/post_model.dart';


final CollectionReference myCollection = Firestore.instance.collection('posts');

class FirestoreService {

  Future<Post> createPosts(String title, String desc,String postdate,String posttype) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());

      final Post post = new Post(title, desc,postdate,posttype);
      final Map<String, dynamic> data =post.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Post.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getPostList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }


}