import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Adding Google Maps to Flutter
/// https://medium.com/flutter-io/google-maps-and-flutter-cfb330f9a245

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.satellite),
      );
      _currentMapType = MapType.satellite;
    } else {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.normal),
      );
      _currentMapType = MapType.normal;
    }
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor
            .hueViolet), //BitmapDescriptor.fromAsset('assets/pitch.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(
                cameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                trackCameraPosition: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.map,
                        size: 36.0,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.add_location,
                        size: 36.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
