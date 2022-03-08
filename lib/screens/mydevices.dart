import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';


class MyDevices extends StatelessWidget {
  const MyDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("My Devices"),

        centerTitle: true,

      ),
    );
  }
}
