import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/posts.dart';
import 'package:final_project/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Posts post = Posts(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "Success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
