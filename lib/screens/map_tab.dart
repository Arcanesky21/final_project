import 'package:final_project/model/air_quality.api.dart';
import 'package:final_project/model/directions_repo.dart';
import 'package:final_project/model/functions.dart';
import 'package:final_project/model/pollution_model.dart';
import 'package:final_project/screens/dest_marker.dart';
import 'package:final_project/screens/marker_detail.dart';
import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:final_project/widgets/pollution_info.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../model/directions_model.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key? key}) : super(key: key);

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(18.0063, -76.7790), zoom: 11.5);
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late List<PollutionModelCurrent> _pm;
  late Future singlePollution;
  double _latitude = 35.779;
  double _longitude = -78.638;

  bool _isLoading = true;

  @override
  void initState() {
    singlePollution = getPollutionCurrent();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    _customInfoWindowController.dispose();

    super.dispose();
  }

  Future<void> getPollutionCurrent() async {
    _pm = await AirPollutionApi.getPollutionCurrent(_longitude, _latitude);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: myDecorationColor,
        ),
        title: const Text('Map'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: _origin!.position, zoom: 14.5, tilt: 50),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Origin'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: _destination!.position, zoom: 14.5, tilt: 50),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('Dest'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            onLongPress: _addMarker,
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 3,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
          ),
          if (_info != null)
            Positioned(
              top: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0)
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuraction}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }

  _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
            markerId: const MarkerId('origin'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MarkerDetails(),
                ),
              );
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
        _destination = null;
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('Destination'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DestMarkerDetails(),
                ),
              );
            },
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
      final directions = await DirectionRepo().getDirections(
          origin: _origin!.position, destination: _destination!.position);
      setState(() => _info = directions);
    }
  }
}
