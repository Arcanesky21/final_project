import 'package:final_project/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:final_project/model/users.dart';

class UserProvider extends ChangeNotifier {
  Users? _user;
  final AuthMethods _authMethods = AuthMethods();

  Users get getUser => _user!;

  Future<void> refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
