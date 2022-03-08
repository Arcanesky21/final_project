import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up function
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //registration
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //firebase storage
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //add to database
        await _firestore.collection('registeredUsers').doc(cred.user!.uid).set({
          'username': userName,
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl

        });
        res = "Success";
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
