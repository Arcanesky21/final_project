import 'package:final_project/model/functions.dart';
import 'package:flutter/material.dart';
import '../model/allscreens.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int curIndex = 0;
  final screens = [
    const HomeScreen(),
    const TabHistoryView(),
    const MyLocation(),
    const MapTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[curIndex],
      bottomNavigationBar: Container(
        decoration: myDecorationColor,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          iconSize: 25,
          selectedItemColor: Colors.white,
          elevation: 0,
          currentIndex: curIndex,
          onTap: (ind) => setState(() => curIndex = ind),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_location),
              label: 'My Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Map',
            ),
          ],
        ),
      ),
    );
  }
}
