// import 'dart:async';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:my_app/additionals/locations_list.dart';
// import 'package:my_app/main.dart';
// import 'package:my_app/widgets/video_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:my_app/additionals/location.dart';
// import 'package:provider/provider.dart';

// class MapGoogle extends StatefulWidget {
//   final void Function(double position) togglePanel;

//   const MapGoogle({
//     Key? key,
//     required this.togglePanel,
//   }) : super(key: key);

//   @override
//   State<MapGoogle> createState() => MapGoogleState();
// }

// class MapGoogleState extends State<MapGoogle> with TickerProviderStateMixin {
//   late AppState appState;
//   String mapTheme = '';
//   late FlickManager flickManager;
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   final List<Location> locations = LocationList.locations;
//   Location? _previousLocation;

//   @override
//   void initState() {
//     super.initState();

//     DefaultAssetBundle.of(context)
//         .loadString('assets/maptheme/dark_theme.json')
//         .then((value) => mapTheme = value);
//     appState = Provider.of<AppState>(context, listen: false);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final currentLocation = appState.currentLocation;

//     if (_previousLocation != currentLocation &&
//         currentLocation != null &&
//         appState.experianceType == "Virtual") {
//       _previousLocation = currentLocation;
//       _moveToNextMarker(currentLocation);
//     }
//   }

//   Future<void> moveToMarker(Marker marker) async {
//     if (appState.experianceType == "Virtual") {
//       final GoogleMapController controllerMap = await _controller.future;
//       final LatLngBounds bounds = await controllerMap.getVisibleRegion();
//       final LatLng mapViewCenter = LatLng(
//         (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
//         (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
//       );

//       final AnimationController controller = AnimationController(
//         duration: const Duration(milliseconds: 300),
//         vsync: this,
//       );

//       final Animation<double> animation = CurvedAnimation(
//         parent: controller,
//         curve: Curves.fastOutSlowIn,
//       );

//       final Tween<double> latTween = Tween<double>(
//         begin: mapViewCenter.latitude,
//         end: marker.position.latitude,
//       );
//       final Tween<double> lngTween = Tween<double>(
//         begin: mapViewCenter.longitude,
//         end: marker.position.longitude,
//       );

//       controller.addListener(() {
//         moveMapViewCenterToCoordinates(
//           LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
//         );
//       });

//       const zoomLevel = 15.0;
//       final target = marker.position;

//       const totalFrames = 10;

//       for (var i = 0; i < totalFrames; i++) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         const zoomAmount = -0.1;
//         final newZoom = zoomLevel + zoomAmount * (i + 1);
//         final updatedCamera = CameraUpdate.newLatLngZoom(target, newZoom);
//         controllerMap.animateCamera(updatedCamera);
//       }

//       await Future.delayed(const Duration(seconds: 2));
//     }
//   }

//   void moveMapViewCenterToCoordinates(final LatLng coordinates) {
//     _controller.future.then((controller) {
//       controller.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(coordinates.latitude, coordinates.longitude),
//         ),
//       );
//     });
//   }

//   void _moveToNextMarker(Location location) async {
//     if (appState.experianceType == "Virtual") {
//       final nextMarker = Marker(
//         markerId: MarkerId(location.id.toString()),
//         icon: BitmapDescriptor.defaultMarker,
//         position: location.coords,
//         infoWindow: InfoWindow(
//           title: location.name,
//         ),
//       );

//       await moveToMarker(nextMarker);
//       _showVideoModal();
//     }
//   }

//   void _showVideoModal() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black.withOpacity(0.5),
//       builder: (BuildContext context) {
//         return VideoModalContent(
//             togglePanel: widget.togglePanel,
//             currentLocation: appState.currentLocation);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     appState = context.watch<AppState>();
//     return Scaffold(
//       body: GoogleMap(
//         padding: const EdgeInsets.only(left: 16.0, bottom: 100.0),
//         mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(
//           target: locations.last.coords,
//           zoom: 11.4,
//         ),
//         markers: Set<Marker>.of(
//           locations.map((location) => Marker(
//                 markerId: MarkerId(location.id.toString()),
//                 position: location.coords,
//                 infoWindow: InfoWindow(
//                   title: location.name,
//                   snippet: location.descr,
//                 ),
//                 onTap: () {
//                   if (appState.experianceType == "Explore") {
//                     appState.changeCurrentLocation(location);
//                     widget.togglePanel(0.5);
//                   }
//                 },
//               )),
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           controller.setMapStyle(mapTheme);
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
