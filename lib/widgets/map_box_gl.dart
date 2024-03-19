import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:my_app/additionals/location.dart';
import 'package:my_app/additionals/locations_list.dart';
import 'package:my_app/main.dart';
import 'package:my_app/widgets/video_modal.dart';
import 'package:provider/provider.dart';

class MapBoxGl extends StatefulWidget {
  final void Function(double position) togglePanel;
  final double panelPosition;

  const MapBoxGl({
    Key? key,
    required this.togglePanel,
    required this.panelPosition,
  }) : super(key: key);

  @override
  State<MapBoxGl> createState() => MapBoxGlState();
}

class MapBoxGlState extends State<MapBoxGl> with TickerProviderStateMixin {
  final List<Location> locations = LocationList.locations;
  late mapbox.MapboxMapController mapController;
  late AppState appState;
  Location? _previousLocation;

  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    appState.addListener(_onAppStateChange);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onAppStateChange() {
    final currentLocation = appState.currentLocation;
    if (_previousLocation != currentLocation && currentLocation != null) {
      _previousLocation = currentLocation;
      mapController.animateCamera(
        mapbox.CameraUpdate.newCameraPosition(
          mapbox.CameraPosition(
            target: currentLocation.coords,
            zoom: 15.0,
          ),
        ),
      );
    }
    if (appState.experianceType == "Explore" && appState.isUserAcceptInfo) {
      widget.togglePanel(0.5);
    }

    if (appState.experianceType == "Virtual" && appState.isUserAcceptInfo) {
      _showVideoModal();
    }
  }

  void _showVideoModal() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return VideoModalContent(
            togglePanel: widget.togglePanel,
            currentLocation: Provider.of<AppState>(context).currentLocation);
      },
    );
  }

  void _onMapCreated(mapbox.MapboxMapController mapboxMapController) {
    mapController = mapboxMapController;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appState.changeCurrentLocation(locations.first);
      mapboxMapController.animateCamera(
        mapbox.CameraUpdate.newCameraPosition(
          mapbox.CameraPosition(
            target: locations.first.coords,
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  void _onStyleLoadedCallback() async {
    var byteData = await rootBundle.load("assets/images/map-pin.png");
    var markerImage = byteData.buffer.asUint8List();

    mapController.addImage("marker", markerImage);

    for (var location in locations) {
      mapController.addSymbol(
        mapbox.SymbolOptions(
          geometry: location.coords,
          textField: location.name, // Имя места в качестве текста маркера
          iconImage: "marker",
          iconSize: 3,
          iconAnchor: "center",
          textOffset: const Offset(0, -3),
        ),
      );
      mapController.onSymbolTapped.add((symbol) {
        for (var location in locations) {
          if (symbol.options.geometry == location.coords) {
            if (appState.experianceType == "Explore") {
              appState.changeCurrentLocation(location);
              widget.togglePanel(0.5);
              mapController.animateCamera(
                mapbox.CameraUpdate.newCameraPosition(mapbox.CameraPosition(
                  target: location.coords,
                  zoom: 10.0,
                )),
              );
            }
            break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.green,
                width: 1,
              ),
            ),
            child: mapbox.MapboxMap(
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: _onStyleLoadedCallback,
              accessToken:
                  "sk.eyJ1IjoibmF6aXRvIiwiYSI6ImNsdG9tZjU5MDBpcXkya3JxMG1zNGhsY2UifQ.vXfTkSYvSq8xv5m6W2hYlQ",
              initialCameraPosition: const mapbox.CameraPosition(
                target: mapbox.LatLng(0.0, 0.0),
                zoom: 12.0,
              ),
              styleString: 'mapbox://styles/mapbox/outdoors-v11',
            )),
      ),
    );
  }
}
