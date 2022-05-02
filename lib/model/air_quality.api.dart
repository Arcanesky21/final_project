import 'dart:convert';
import 'package:final_project/model/.env.dart';
import 'package:final_project/model/pollution_model.dart';
import 'package:http/http.dart' as http;

class AirPollutionApi {


  //pollution history api call
  static Future<List<PollutionModelHistory>> getPollutionHistory() async {
    var uri = Uri.https('air-quality.p.rapidapi.com', '/history/airquality',
        {"lon": "-78.638", "lat": "35.779"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "air-quality.p.rapidapi.com",
      "x-rapidapi-key": RapidAPIKey,
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];


    for (int i = 49; i < 72; i++) {
      _temp.add(data['data'][i]);
    }

    return PollutionModelHistory.pollutionHistoryFromSnapshot(_temp);
  }

  //current pollution api call
  static Future<List<PollutionModelCurrent>> getPollutionCurrent(double longitude, double latitude) async {
    var uri = Uri.https('air-quality.p.rapidapi.com', '/current/airquality',
        {"lon": "$longitude", "lat": "$latitude"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "air-quality.p.rapidapi.com",
      "x-rapidapi-key": RapidAPIKey,
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    _temp.add(data);

    return PollutionModelCurrent.pollutionCurrentFromSnapshot(_temp);
  }
}
