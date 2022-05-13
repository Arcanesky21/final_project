import 'dart:convert';

import 'package:http/http.dart' as http;

import 'article_model.dart';

//Now let's make the HTTP request services
// this class will alows us to make a simple get http request
// from the API and get the Articles and then return a list of Articles

class ApiService {
  //let's add an Endpoint URL, you can check the website documentation
  // and learn about the different Endpoint
  //for this example I'm going to use a single endpoint

  //NOTE: make sure to use your OWN apikey, you can make a free acount and
  // choose a developer option it's FREE
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=88c014f8cd4f4e7f83a5dd8f8d0b930a";

  //Now let's create the http request function
  // but first let's import the http package

  Future<List<Article>> getArticle() async {
        var uri = Uri.https('air-quality.p.rapidapi.com', '/current/airquality',
        );

    final response = await http.get(uri, headers: {
      "X-RapidAPI-Host": "climate-change-news12.p.rapidapi.com",
	"X-RapidAPI-Key": "7bf3231408msh1821937899571edp145138jsn8b453fb089d9",
	"useQueryString": 'true'
    });
  
    final res = await http.get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      //nothing after this is executed

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
