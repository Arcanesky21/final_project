import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  List? feedback;
  String? userName;

  //user model
  UserModel(
      {this.userName, this.uid, this.email, this.firstName, this.lastName, this.feedback});

  //get data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userName: map['userName'],
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        feedback: map['feedback']);
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'feedback': FieldValue.arrayUnion(feedback!)
    };
  }
}
