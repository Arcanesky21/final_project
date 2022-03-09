import 'package:final_project/model/allscreens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()));
}

User? user = FirebaseAuth.instance.currentUser;

Widget buildSearchField() {
  const color = Colors.white;

  return TextField(
    style: const TextStyle(color: color),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      hintText: 'Search',
      hintStyle: const TextStyle(color: color),
      prefixIcon: const Icon(Icons.search, color: color),
      filled: true,
      fillColor: Colors.white12,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: color.withOpacity(0.7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: color.withOpacity(0.7)),
      ),
    ),
  );
}

const TextStyle myBodyText = TextStyle(
  fontSize: 17,
  color: Colors.white,
);

const BoxDecoration myDecorationColor = BoxDecoration(
  gradient: LinearGradient(
      colors: [Colors.blue, Colors.green],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft),
);

const BoxDecoration myDecorationColorFAB = BoxDecoration(
  gradient: LinearGradient(
      colors: [Colors.blue, Colors.green],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft),
  shape: BoxShape.circle,
);


