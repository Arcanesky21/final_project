import 'package:final_project/model/air_quality.api.dart';
import 'package:final_project/model/pollution_model.dart';
import 'package:final_project/widgets/pollution_info.dart';
import 'package:flutter/material.dart';

class HistoryOneDay extends StatefulWidget {
  const HistoryOneDay({Key? key}) : super(key: key);

  @override
  _HistoryOneDayState createState() => _HistoryOneDayState();
}

class _HistoryOneDayState extends State<HistoryOneDay> {
  late List<PollutionModelHistory> _pm;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getPollutionHistory();
  }

  Future<void> getPollutionHistory() async {
    _pm = await AirPollutionApi.getPollutionHistory();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 3,
                          separatorBuilder: (context, index) => const Divider(thickness: 1,
                            color: Colors.green,
                            indent: 20,
                            endIndent: 20,),
                          itemBuilder: (context, index) {
                            return PollutionDataHistory(
                              airQualityIndex: _pm[index].airQualityIndex,
                              carbonMonoxide: _pm[index].carbonMonoxide,
                              ozone: _pm[index].ozone,
                              sulferDioxide: _pm[index].sulferDioxide,
                              nitrogenDioxide: _pm[index].nitrogenDioxide,
                              fineParticleMatter: _pm[index].fineParticleMatter,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
