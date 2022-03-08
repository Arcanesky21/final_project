import 'package:final_project/model/functions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PollutionDataHistory extends StatefulWidget {
  const PollutionDataHistory({
    Key? key,
    required this.airQualityIndex,
    required this.carbonMonoxide,
    required this.ozone,
    required this.sulferDioxide,
    required this.nitrogenDioxide,
    required this.fineParticleMatter,
  }) : super(key: key);

  final int airQualityIndex;
  final double carbonMonoxide;
  final double ozone;
  final double sulferDioxide;
  final double nitrogenDioxide;
  final double fineParticleMatter;

  @override
  State<PollutionDataHistory> createState() => _PollutionDataHistoryState();
}

class _PollutionDataHistoryState extends State<PollutionDataHistory> {
  Color? circleColor;

  final healthIndicatorScale = 500;
  late String healthIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: bodyCard(),
    );
  }

  bodyCard() => Card(
        shadowColor: Colors.green,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Carbon Monoxide : ${widget.carbonMonoxide}',
                        style: myBodyText,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Ozone: ${widget.ozone}', style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Sulfer Dioxide: ${widget.sulferDioxide}',
                          style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Nitrogen Dioxide: ${widget.nitrogenDioxide}',
                          style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Fine Particle Matter: ${widget.fineParticleMatter}',
                          style: myBodyText),
                    ],
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 90,
                    animation: true,
                    lineWidth: 13,
                    progressColor: colorChange(),
                    percent: (widget.airQualityIndex / healthIndicatorScale),
                    center: Text('${widget.airQualityIndex}'),
                    footer: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        healthIndicator,
                        style: myBodyText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Color? colorChange() {
    if (widget.airQualityIndex <= 50) {
      circleColor = Colors.green;
      healthIndicator = 'Good';
    } else if (widget.airQualityIndex <= 100) {
      circleColor = Colors.yellow;
      healthIndicator = 'Moderate';
    } else if (widget.airQualityIndex <= 150) {
      circleColor = Colors.orange;
      healthIndicator = 'Unhealthy for Sensitive Groups';
    } else if (widget.airQualityIndex <= 200) {
      circleColor = Colors.red;
      healthIndicator = 'Unhealth';
    } else if (widget.airQualityIndex <= 300) {
      circleColor = Colors.purple;
      healthIndicator = 'Very Unhealthy';
    } else {
      circleColor = Colors.black;
      healthIndicator = 'Hazardous';
    }

    return circleColor;
  }
}

//current pollution body
class CurrentPollution extends StatefulWidget {
  const CurrentPollution(
      {Key? key,
      required this.airQualityIndex,
      required this.carbonMonoxide,
      required this.ozone,
      required this.sulferDioxide,
      required this.nitrogenDioxide,
      required this.fineParticleMatter,
      required this.cityName,
      required this.preDominantPollenType})
      : super(key: key);

  final int airQualityIndex;
  final double carbonMonoxide;
  final double ozone;
  final double sulferDioxide;
  final double nitrogenDioxide;
  final double fineParticleMatter;
  final String cityName;
  final String preDominantPollenType;

  @override
  _CurrentPollutionState createState() => _CurrentPollutionState();
}

class _CurrentPollutionState extends State<CurrentPollution> {
  Color? circleColor;

  final healthIndicatorScale = 500;
  late String healthIndicator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: bodyCard(),
    );
  }

  bodyCard() => Card(
        shadowColor: Colors.green,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: myDecorationColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text('City Name: ${widget.cityName}', style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Predominant Pollen Type: ${widget.preDominantPollenType}',
                          style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Carbon Monoxide : ${widget.carbonMonoxide}',
                        style: myBodyText,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Ozone: ${widget.ozone}', style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Sulfer Dioxide: ${widget.sulferDioxide}',
                          style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Nitrogen Dioxide: ${widget.nitrogenDioxide}',
                          style: myBodyText),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Fine Particle Matter: ${widget.fineParticleMatter}',
                          style: myBodyText),
                    ],
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    radius: 90,
                    animation: true,
                    lineWidth: 13,
                    progressColor: colorChange(),
                    percent: (widget.airQualityIndex / healthIndicatorScale),
                    center: Text('${widget.airQualityIndex}'),
                    footer: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        healthIndicator,
                        style: myBodyText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Color? colorChange() {
    if (widget.airQualityIndex <= 50) {
      circleColor = Colors.green;
      healthIndicator = 'Good';
    } else if (widget.airQualityIndex <= 100) {
      circleColor = Colors.yellow;
      healthIndicator = 'Moderate';
    } else if (widget.airQualityIndex <= 150) {
      circleColor = Colors.orange;
      healthIndicator = 'Unhealthy for Sensitive Groups';
    } else if (widget.airQualityIndex <= 200) {
      circleColor = Colors.red;
      healthIndicator = 'Unhealthy';
    } else if (widget.airQualityIndex <= 300) {
      circleColor = Colors.purple;
      healthIndicator = 'Very Unhealthy';
    } else {
      circleColor = Colors.black;
      healthIndicator = 'Hazardous';
    }

    return circleColor;
  }
}
