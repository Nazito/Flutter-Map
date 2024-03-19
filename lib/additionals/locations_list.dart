import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'location.dart';

class LocationList {
  static final List<Location> locations = [
    Location(
        id: 1,
        name: "Burning Man",
        descr:
            "Burning Man is an annual experimental festival in the Nevada desert, USA. Participants create a temporary city celebrating radical self-expression and self-reliance.",
        preview:
            const AssetImage('assets/images/burning_man/burning_man_main.jpg'),
        images: [
          'assets/images/burning_man/burning_man_1.jpg',
          'assets/images/burning_man/burning_man_2.jpg',
        ],
        audio: AssetSource('audio/Burning_Man.mp3'),
        coords: const LatLng(40.7829, -119.2006),
        interviewers: ["Unknown"],
        interviewees: ["Brad Pitt"],
        video: 'assets/video/Burning_Man.mp4'),
    Location(
        id: 2,
        name: "Brazil Carnaval",
        descr:
            "Brazil Carnaval is a vibrant annual festival known for its colorful parades, samba music, and extravagant costumes. It takes place in cities like Rio de Janeiro and São Paulo.",
        preview: const AssetImage(
            'assets/images/brazil_carnaval/brazil_carnaval_main.jpg'),
        images: [
          'assets/images/brazil_carnaval/brazil_carnaval_1.jpg',
          'assets/images/brazil_carnaval/brazil_carnaval_2.jpg',
        ],
        audio: AssetSource('audio/Brazil_Carnaval.mp3'),
        coords: const LatLng(-22.9068, -43.1729),
        interviewers: ["Unknown", "Angelina Jolie"],
        interviewees: ["Leonardo DiCaprio", "Jennifer Aniston"],
        video: 'assets/video/Brazil_Carnaval.mp4'),
    Location(
      id: 3,
      name: "Oktoberfest",
      descr:
          "Oktoberfest is the world's largest beer festival held annually in Munich, Germany. It features traditional Bavarian food, music, and, of course, plenty of beer.",
      preview:
          const AssetImage('assets/images/oktoberfest/oktoberfest_main.jpg'),
      images: [
        'assets/images/oktoberfest/oktoberfest_1.jpg',
        'assets/images/oktoberfest/oktoberfest_2.jpg',
      ],
      audio: AssetSource('audio/Oktoberfest.mp3'),
      coords: const LatLng(48.1351, 11.5820),
      interviewers: ["Tom Hanks", "Meryl Streep"],
      interviewees: ["George Clooney", "Julia Roberts"],
      video: 'assets/video/Oktoberfest.mp4',
    ),
    Location(
      id: 4,
      name: "Day of Dead",
      descr:
          "Day of the Dead is a vibrant Mexican holiday honoring deceased loved ones. Celebrated with colorful altars, marigolds, and traditional foods, it takes place throughout Mexico.",
      preview: const AssetImage(
        'assets/images/day_of_dead/day_of_dead_main.jpg',
      ),
      images: [
        'assets/images/day_of_dead/day_of_dead_1.jpg',
        'assets/images/day_of_dead/day_of_dead_2.jpg',
      ],
      audio: AssetSource('audio/DayOfDead.mp3'),
      coords: const LatLng(19.4326, -99.1332),
      interviewers: ["Denzel Washington", "Charlize Theron"],
      interviewees: ["Johnny Depp", "Sandra Bullock"],
      video: 'assets/video/DayOfDead.mp4',
    ),
    Location(
      id: 5,
      name: "Rodeo",
      descr:
          "Rodeo is a competitive sport that originated in the United States, featuring events like bull riding, barrel racing, and calf roping. It is held in various cities across the country.",
      preview: const AssetImage('assets/images/rodeo/rodeo_main.jpg'),
      images: [
        'assets/images/rodeo/rodeo_1.jpg',
        'assets/images/rodeo/rodeo_2.jpg',
      ],
      audio: AssetSource('audio/Rodeo.mp3'),
      coords: const LatLng(29.7604, -95.3698),
      interviewers: ["Robert Downey Jr."],
      interviewees: ["Nicole Kidman"],
      video: 'assets/video/Rodeo.mp4',
    ),
  ];
}
