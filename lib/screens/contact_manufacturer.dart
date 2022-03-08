import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class ContactManufact extends StatefulWidget {
  const ContactManufact({Key? key}) : super(key: key);

  @override
  State<ContactManufact> createState() => _ContactManufactState();
}

class _ContactManufactState extends State<ContactManufact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manufacturer Details"),
        centerTitle: true,
      ),
      drawer: const NavigationDrawerWidget(),
      body: Column(
        children: const [],
      ),
    );
  }
}
