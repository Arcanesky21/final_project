import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('My Location'),
      ),
      body: const SizedBox(
        height: 20,
        child: Text('random'),
      ),
    );
  }
}
