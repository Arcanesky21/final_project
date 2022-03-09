import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/model/users.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore
        .collection('registeredUsers')
        .doc(currentUser.uid)
        .get();

    return model.Users.fromSnap(snap);
  }

  //sign up function
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String userName,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = "Some error occurred";
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
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file!, false);

        //add to database

        model.Users user = model.Users(
            username: userName,
            name: name,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);
        await _firestore
            .collection('registeredUsers')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //log in
  Future<String> login(
      {required String email, required String password}) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
