import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/posts.dart';
import 'package:final_project/resources/storage_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "Success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> upVotePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove(
            [uid],
          )
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion(
            [uid],
          )
        });
      }
    } catch (err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String name, String uid,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'likes': [],
        });
      } else {
        Fluttertoast.showToast(msg: 'Text is Empty');
      }
    } catch (err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    }
  }

  //delete post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    }
  }

  //follow user
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('registeredUsers').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('registeredUsers').doc(followId).update(
          {
            'followers': FieldValue.arrayRemove(
              [uid],
            ),
          },
        );
        await _firestore.collection('registeredUsers').doc(uid).update(
          {
            'following': FieldValue.arrayRemove(
              [followId],
            ),
          },
        );
      } else {
        await _firestore.collection('registeredUsers').doc(followId).update(
          {
            'followers': FieldValue.arrayUnion(
              [uid],
            ),
          },
        );
        await _firestore.collection('registeredUsers').doc(uid).update(
          {
            'following': FieldValue.arrayUnion(
              [followId],
            ),
          },
        );
      }
    } catch (err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    }
  }
}
