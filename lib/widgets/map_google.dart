import 'dart:async';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:my_app/widgets/video_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/additionals/location.dart';

class MapGoogle extends StatefulWidget {
  final void Function(dynamic state) handleChangeCurrentLocation;
  final void Function(double position) togglePanel;
  final List<Location> locations;
  final bool isUserAcceptInfo;
  final String? experianceType;
  final Location? currentLocation;

  const MapGoogle({
    Key? key,
    required this.handleChangeCurrentLocation,
    required this.togglePanel,
    required this.locations,
    required this.isUserAcceptInfo,
    required this.experianceType,
    required this.currentLocation,
  }) : super(key: key);

  @override
  State<MapGoogle> createState() => MapGoogleState();
}

class MapGoogleState extends State<MapGoogle> with TickerProviderStateMixin {
  String mapTheme = '';
  late FlickManager flickManager;
  final List<Marker> _markers = <Marker>[];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    widget.isUserAcceptInfo ? loadData() : null;
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/dark_theme.json')
        .then((value) => mapTheme = value);
  }

  @override
  void didUpdateWidget(MapGoogle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isUserAcceptInfo && _markers.isEmpty) {
      loadData();
    }
    if (widget.currentLocation != oldWidget.currentLocation) {
      if (widget.currentLocation != null) {
        _moveToNextMarker(widget.currentLocation!);
      }
    }
  }

  Future<void> moveToMarker(Marker marker) async {
    if (widget.experianceType == "Virtual") {
      final GoogleMapController controllerMap = await _controller.future;
      final LatLngBounds bounds = await controllerMap.getVisibleRegion();
      final LatLng mapViewCenter = LatLng(
        (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
        (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
      );

      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      final Animation<double> animation = CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      );

      final Tween<double> latTween = Tween<double>(
        begin: mapViewCenter.latitude,
        end: marker.position.latitude,
      );
      final Tween<double> lngTween = Tween<double>(
        begin: mapViewCenter.longitude,
        end: marker.position.longitude,
      );

      controller.addListener(() {
        moveMapViewCenterToCoordinates(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        );
      });

      const zoomLevel = 15.0;
      final target = marker.position;

      const totalFrames = 10;

      for (var i = 0; i < totalFrames; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        const zoomAmount = -0.1;
        final newZoom = zoomLevel + zoomAmount * (i + 1);
        final updatedCamera = CameraUpdate.newLatLngZoom(target, newZoom);
        controllerMap.animateCamera(updatedCamera);
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  void moveMapViewCenterToCoordinates(final LatLng coordinates) {
    _controller.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(coordinates.latitude, coordinates.longitude),
        ),
      );
    });
  }

  loadData() async {
    if (widget.locations.isNotEmpty) {
      for (var location in widget.locations) {
        final marker = Marker(
          markerId: MarkerId(location.id.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: location.coords,
          infoWindow: InfoWindow(
            title: location.name,
          ),
          onTap: () {
            if (widget.experianceType == "Explore") {
              widget.handleChangeCurrentLocation(location);
              widget.togglePanel(0.5);
            }
          },
        );
        _markers.add(marker);
      }
    }
  }

  void _moveToNextMarker(Location location) async {
    if (widget.experianceType == "Virtual") {
      final nextMarker = Marker(
        markerId: MarkerId(location.id.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: location.coords,
        infoWindow: InfoWindow(
          title: location.name,
        ),
      );
      _markers.add(nextMarker);
      await moveToMarker(nextMarker);
      widget.handleChangeCurrentLocation(location);
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
            currentLocation: widget.currentLocation);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        padding: const EdgeInsets.only(left: 16.0, bottom: 100.0),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: widget.locations.last.coords,
          zoom: 11.4,
        ),
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
