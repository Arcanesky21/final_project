import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String username;
  final String uid;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Posts({
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.likes,
    required this.datePublished,
    required this.profileImage,
    required this.postUrl,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "username": username,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profileImage,
        "likes": likes,
        "postUrl": postUrl
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
        username: snapshot['username'],
        description: snapshot['description'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes'],
        postUrl: snapshot['postUrl'],
        profileImage: snapshot['profImage']);
  }
}
