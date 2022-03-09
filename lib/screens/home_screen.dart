import 'package:final_project/model/air_quality.api.dart';
import 'package:final_project/model/functions.dart';
import 'package:final_project/model/pollution_model.dart';
import 'package:final_project/model/users.dart';
import 'package:final_project/resources/user_providers.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:final_project/widgets/pollution_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<PollutionModelCurrent> _pm;
  late Future singlePollution;
  double _latitude = 35.779;
  double _longitude = -78.638;

  bool _isLoading = true;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please Keep Location on');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied forever');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        singlePollution = getPollutionCurrent();

      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    singlePollution = getPollutionCurrent();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }



  Future<void> getPollutionCurrent() async {
    _pm = await AirPollutionApi.getPollutionCurrent(_longitude, _latitude);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        flexibleSpace: Container(decoration: myDecorationColor),
        title: const Text(
          "Home",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    FutureBuilder(
                        future: singlePollution,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('none');
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.done:
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: _pm.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    return CurrentPollution(
                                      cityName: _pm[index].cityName,
                                      airQualityIndex:
                                          _pm[index].airQualityIndex,
                                      carbonMonoxide: _pm[index].carbonMonoxide,
                                      ozone: _pm[index].ozone,
                                      preDominantPollenType:
                                          _pm[index].preDominantPollenType,
                                      sulferDioxide: _pm[index].sulferDioxide,
                                      nitrogenDioxide:
                                          _pm[index].nitrogenDioxide,
                                      fineParticleMatter:
                                          _pm[index].fineParticleMatter,
                                    );
                                  },
                                ),
                              );
                            default:
                              return const Text('default');
                          }
                        }),
                  ],
                ),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: myDecorationColorFAB,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              setState(() {
                _determinePosition();
              });
            },
            child: const Icon(Icons.update),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  //logout function

}
