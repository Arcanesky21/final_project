import 'package:final_project/model/allscreens.dart';
import 'package:final_project/model/functions.dart';
import 'package:flutter/material.dart';

class SocialMediaSection extends StatefulWidget {
  const SocialMediaSection({Key? key}) : super(key: key);

  @override
  State<SocialMediaSection> createState() => _SocialMediaSectionState();
}

class _SocialMediaSectionState extends State<SocialMediaSection> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final socialMediaScreens = [
    const FeedScreen(),
    const SearchScreen(),
    const AddPostsScreen(),
    const FavouritesScreen(),
    const Profile(),
  ];

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        pageSnapping: true,
        children: socialMediaScreens,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        decoration: myDecorationColor,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.transparent,
          iconSize: 25,
          elevation: 0,
          currentIndex: _page,
          onTap: navigationTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Feed',
              icon: Icon(Icons.forum,
                  color: _page == 0 ? Colors.white : Colors.grey[700]),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search,
                  color: _page == 1 ? Colors.white : Colors.grey[700]),
            ),
            BottomNavigationBarItem(
              label: 'Add Post',
              icon: Icon(Icons.add_circle,
                  color: _page == 2 ? Colors.white : Colors.grey[700]),
            ),
            BottomNavigationBarItem(
              label: 'Favourites',
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? Colors.white : Colors.grey[700]),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person,
                  color: _page == 4 ? Colors.white : Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
