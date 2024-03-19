import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Location {
  int id;
  String name;
  String descr;
  AssetSource audio;
  AssetImage preview;
  String video;
  List<String> images;
  List<String> interviewers;
  List<String> interviewees;
  LatLng coords;

  Location(
      {required this.name,
      required this.descr,
      required this.preview,
      required this.audio,
      required this.video,
      required this.coords,
      required this.images,
      required this.interviewers,
      required this.interviewees,
      required this.id});
}
