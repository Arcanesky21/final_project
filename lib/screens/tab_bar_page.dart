import 'package:final_project/model/functions.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'history_tab.dart';
import 'history_tab_oneday.dart';
import 'history_tab_twoday.dart';

class TabHistoryView extends StatefulWidget {
  const TabHistoryView({Key? key}) : super(key: key);

  @override
  _TabHistoryViewState createState() => _TabHistoryViewState();
}

class _TabHistoryViewState extends State<TabHistoryView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: myDecorationColor,
          ),
          title: const Text('History'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: '3 Hours',
                icon: Icon(Icons.hourglass_bottom),
              ),
              Tab(
                text: '8 Hours',
                icon: Icon(Icons.hourglass_top),
              ),
              Tab(
                text: '24 Hours',
                icon: Icon(Icons.hourglass_empty),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryOneDay(),
            HistoryTwoDay(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
