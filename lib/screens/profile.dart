import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/functions.dart';
import 'package:final_project/model/user_model.dart';
import 'package:final_project/widgets/follow_button.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool isLoading = false;
  var userData = {};
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        flexibleSpace: Container(decoration: myDecorationColor),
        title: Text("${loggedInUser.firstName} ${loggedInUser.lastName}"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://otakukart.com/wp-content/uploads/2021/11/Itachi-Uchiha-scaled.jpeg'),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(12, 'Posts'),
                              buildStatColumn(150, 'Followers'),
                              buildStatColumn(10, 'Following')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              FollowButton(
                                  textColor: Colors.blue,
                                  borderColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  text: 'Edit Profile')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "${loggedInUser.firstName} ${loggedInUser.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: const Text('Some description'),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.green[900],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label.toString(),
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
