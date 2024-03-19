import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapBoxGlFlutterMap extends StatefulWidget {
  final void Function(double position) togglePanel;

  const MapBoxGlFlutterMap({
    Key? key,
    required this.togglePanel,
  }) : super(key: key);

  @override
  State<MapBoxGlFlutterMap> createState() => MapBoxGlFlutterMapState();
}

class MapBoxGlFlutterMapState extends State<MapBoxGlFlutterMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapBox')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(27.175002, 78.0421170902921),
          zoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/nazito/cltsbz3mu013401nr2q1k38gt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w",
            // "https://api.mapbox.com/styles/v1/nazito/cltri2f8200n101pce9gig0l7/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w",
            // "https://api.mapbox.com/styles/v1/acidhue/cjvb13pgd12t01flpd97ub8dx/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w",

            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w',
              'id': 'mapbox://styles/nazito/cltrag3cw00di01pjf49wfi6m'
            },
            // urlTemplate:
            //     "https://api.mapbox.com/styles/v1/{id}/tiles/512/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w",
            // additionalOptions: const {
            //   'accessToken':
            //       'pk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tODJhbTBqOGIycXJxcmNyODV1ZWgifQ.ymFrBXv0XLNCxrtsqqKA5w',
            //   'id': 'mapbox.mapbox-streets-v8',
            // },
          )
        ],
      ),
    );
  }
}
