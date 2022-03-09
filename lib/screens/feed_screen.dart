import 'package:final_project/model/functions.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:final_project/widgets/post_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        flexibleSpace: Container(decoration: myDecorationColor),
        title: const Text('Posts'),
      ),
      body: const PostCard(),
    );
  }
}
