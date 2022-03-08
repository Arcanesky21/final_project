import 'package:final_project/model/functions.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubmitFeedback extends StatefulWidget {
  const SubmitFeedback({Key? key}) : super(key: key);

  @override
  State<SubmitFeedback> createState() => _SubmitFeedbackState();
}

class _SubmitFeedbackState extends State<SubmitFeedback> {
  final feed = FirebaseFirestore.instance.collection('feedback');
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  //creates an instance of the database
  void initState() {
    // implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final feedbackController = TextEditingController();
  var getUserFeedback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: myDecorationColor,
          ),
          title: const Text("Feedbacks Submitted"),
          centerTitle: true,
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              shape: BoxShape.circle),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "Submit a Feedback",
                      textAlign: TextAlign.center,
                    ),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            maxLines: null,
                            controller: feedbackController,
                            validator: (value) {
                              RegExp regExp = RegExp(r'0-9a-zA-Z,.');
                              if (value!.isEmpty) {
                                return ("Cannot submit empty feedback");
                              }
                              if (!value.contains(regExp)) {
                                return ("no special characters");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              feedbackController.text = value!;
                            },
                            decoration: const InputDecoration(
                              label: Center(
                                child: Text("Enter Feedback Here"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            decoration: myDecorationColor,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent, elevation: 0),
                              onPressed: () {
                                submitFeedback(feedbackController.text);
                                Navigator.pop(context);
                              },
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.green,
                );
              }
              return ListView(
                children: [
                  if (getUserFeedback == null)
                    const Text(
                      'No Feedback',
                      textAlign: TextAlign.center,
                    )
                  else
                    for (var item in getUserFeedback['feedback'])
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(item),
                      )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void submitFeedback(String feedback) async {
    if (_formKey.currentState!.validate()) {
      postFeedback();
    }
  }

  void postFeedback() async {
    int? count = 1;
    UserModel feedbackModel = UserModel();

    final userFeedbackDoc =
        FirebaseFirestore.instance.collection('feedback').doc(loggedInUser.uid);

    final doc = await userFeedbackDoc.get();
    if (doc.exists) {
      feedbackModel.uid = loggedInUser.uid;
      feedbackModel.firstName = loggedInUser.firstName;
      feedbackModel.feedback![count] = feedbackController.text;
      feedbackModel.lastName = loggedInUser.lastName;

      List field = doc.data()!['feedback'];
      if (field.contains(feedbackController.text) == true) {
        userFeedbackDoc.update({
          'feedback': FieldValue.arrayRemove([feedbackController.text])
        });
      } else {
        userFeedbackDoc.update({
          'feedback': FieldValue.arrayUnion([feedbackController.text])
        });
      }
    } else {
      await userFeedbackDoc.set(feedbackModel.toMap2()).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  getUserData() async {
    var userDocData = FirebaseFirestore.instance
        .collection('feedback')
        .doc('${loggedInUser.uid}');

    getUserFeedback = await userDocData.get();
    getUserFeedback = getUserFeedback.data();
    if (getUserFeedback != null) {
      return getUserFeedback;
    }
  }
}
