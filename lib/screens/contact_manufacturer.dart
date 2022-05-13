import 'package:final_project/model/api_service.dart';
import 'package:final_project/model/article_model.dart';
import 'package:final_project/model/functions.dart';
import 'package:final_project/widgets/custom_list_tile.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class ContactManufact extends StatefulWidget {
  const ContactManufact({Key? key}) : super(key: key);

  @override
  State<ContactManufact> createState() => _ContactManufactState();
}

class _ContactManufactState extends State<ContactManufact> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(decoration: myDecorationColor),
          title: const Text("News"),
          centerTitle: true,
        ),
        drawer: const NavigationDrawerWidget(),
        body: FutureBuilder(
            future: client.getArticle(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              //let's check if we got a response or not
              if (snapshot.hasData) {
                //Now let's make a list of articles
                List<Article> articles = snapshot.data!;
                
                return ListView.builder(
                  //Now let's create our custom List tile
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index], context),
                );
              }
              return const Center(
                child: Text('no data'),
              );
            }));
  }
}
