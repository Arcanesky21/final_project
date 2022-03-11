import 'package:final_project/model/functions.dart';
import 'package:final_project/model/allscreens.dart';
import 'package:final_project/model/users.dart';
import 'package:final_project/resources/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  //creates an instance of the database

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  late final urlImage =
      "https://static.fandomspot.com/images/11/22153/00-featured-naruto-shippuden-itachi-covering-his-bleeding-eyes-screenshot-al.jpg";

  @override
  Widget build(BuildContext context) {
    final Users user = Provider.of<UserProvider>(context).getUser;
    //side window
    return Drawer(
      child: Material(
        child: Container(
          decoration: myDecorationColor,
          child: ListView(children: <Widget>[
            buildHeader(
              urlImage: user.photoUrl,
              name: user.username,
              lname: user.name,
              onClicked: () {},
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  //search field
                  buildSearchField(),
                  const SizedBox(
                    height: 5,
                  ),
                  //devices
                  buildMenuItem(
                      text: 'Devices',
                      icon: Icons.devices_other,
                      onClicked: () => selectedItem(context, 0)),
                  const SizedBox(
                    height: 5,
                  ),
                  //user settings
                  buildMenuItem(
                      text: 'Social Media',
                      icon: Icons.question_answer,
                      onClicked: () => selectedItem(context, 1)),
                  const SizedBox(
                    height: 5,
                  ),
                  //submit feedback
                  buildMenuItem(
                      text: 'Submit Feedback',
                      icon: Icons.feedback,
                      onClicked: () => selectedItem(context, 2)),
                  const SizedBox(
                    height: 5,
                  ),
                  //contact manufacturer
                  buildMenuItem(
                      text: 'Contact Manufacturer',
                      icon: Icons.engineering,
                      onClicked: () => selectedItem(context, 3)),
                  const SizedBox(
                    height: 5,
                  ),
                  //request maintenance
                  buildMenuItem(
                      text: 'Request Technician',
                      icon: Icons.question_answer,
                      onClicked: () => selectedItem(context, 4)),
                  const SizedBox(
                    height: 5,
                  ),
                  //divider
                  const Divider(
                    color: Colors.white70,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //re-sync

                  buildMenuItem(
                    text: "Home",
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  //Logout
                  buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout,
                      onClicked: () {
                        logout(context);
                      }),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyDevices(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SocialMediaSection(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SubmitFeedback(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ContactManufact(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RequestTech(),
        ));
        break;

      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MainHome(),
        ));
        break;

      //logout - change

    }
  }

  buildHeader({
    required String urlImage,
    required String name,
    required String lname,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlImage),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    lname,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                child: Icon(Icons.notifications),
              )
            ],
          ),
        ),
      );
}

//logout function
