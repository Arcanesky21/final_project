//pollution history api map
class PollutionModelHistory {
  final int airQualityIndex;
  final double carbonMonoxide;
  final double ozone;
  final double sulferDioxide;
  final double nitrogenDioxide;
  final double fineParticleMatter;

  PollutionModelHistory({
    required this.airQualityIndex,
    required this.carbonMonoxide,
    required this.ozone,
    required this.sulferDioxide,
    required this.nitrogenDioxide,
    required this.fineParticleMatter,
  });

  factory PollutionModelHistory.fromJson(dynamic json) {
    return PollutionModelHistory(
      airQualityIndex: int.parse(json['aqi'].toString()),
      carbonMonoxide: double.parse(json['co'].toString()),
      ozone: double.parse(json['o3'].toString()),
      sulferDioxide: double.parse(json['so2'].toString()),
      nitrogenDioxide: double.parse(json['no2'].toString()),
      fineParticleMatter: double.parse(json['pm25'].toString()),
    );
  }

  static List<PollutionModelHistory> pollutionHistoryFromSnapshot(
      List snapshot) {
    return snapshot.map((data) {
      return PollutionModelHistory.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return ' PollutionModelHistory{airQualityIndex: $airQualityIndex, carbonMonoxide: $carbonMonoxide, ozone: $ozone, sulferDioxide: $sulferDioxide,  nitrogenDioxide: $nitrogenDioxide, fineParticleMatter: $fineParticleMatter, }';
  }


}
//current pollution api map
class PollutionModelCurrent {
  final int airQualityIndex;
  final double carbonMonoxide;
  final double ozone;
  final double sulferDioxide;
  final String preDominantPollenType;
  final String cityName;
  final double nitrogenDioxide;
  final double fineParticleMatter;

  PollutionModelCurrent(
      {required this.airQualityIndex,
      required this.carbonMonoxide,
      required this.ozone,
      required this.sulferDioxide,
      required this.nitrogenDioxide,
      required this.fineParticleMatter,
      required this.preDominantPollenType,
      required this.cityName});

  factory PollutionModelCurrent.fromJson(dynamic json) {
    return PollutionModelCurrent(
        airQualityIndex: int.parse(json['data'][0]['aqi'].toString()),
        carbonMonoxide: double.parse(json['data'][0]['co'].toString()),
        ozone: double.parse(json['data'][0]['o3'].toString()),
        sulferDioxide: double.parse(json['data'][0]['so2'].toString()),
        nitrogenDioxide: double.parse(json['data'][0]['no2'].toString()),
        fineParticleMatter: double.parse(json['data'][0]['pm25'].toString()),
        preDominantPollenType:
            json['data'][0]['predominant_pollen_type'] as String,
        cityName: json['city_name'] as String);
  }

  static List<PollutionModelCurrent> pollutionCurrentFromSnapshot(
      List snapshot) {
    return snapshot.map((data) {
      return PollutionModelCurrent.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'PollutionModelCurrent{airQualityIndex: $airQualityIndex, $carbonMonoxide: $carbonMonoxide, ozone: $ozone, sulferDioxide: $sulferDioxide, nitrogenDioxide: $nitrogenDioxide, fineParticleMatter: $fineParticleMatter, preDominantPollenType: $preDominantPollenType, cityName: $cityName,}';
  }
}
