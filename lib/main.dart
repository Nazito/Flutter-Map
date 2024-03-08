import 'package:flutter/material.dart';
import 'package:my_app/additionals/location.dart';
import 'package:my_app/additionals/locations_list.dart';
import 'package:my_app/screens/experience_screen.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/intro_screen.dart';
import 'package:my_app/screens/map_screen.dart';
import 'package:my_app/utils/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  ApptState createState() => ApptState();
}

class ApptState extends State<App> {
  Location? currentLocation;
  String? experianceType;
  bool isUserAcceptInfo = false;

  _handleChangeCurrentLocation(loc) {
    setState(() {
      currentLocation = loc;
    });
  }

  _handleChangeExperianceType(type) {
    setState(() {
      experianceType = type;
    });
  }

  _handleChangeUserAcceptInfo(status) {
    setState(() {
      isUserAcceptInfo = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/intro': (context) => const IntroScreen(),
        '/experience': (context) => ExperienceScreen(
            handleChangeExperianceType: _handleChangeExperianceType),
        '/map': (context) => MapScreen(
              locations: LocationList.locations,
              isUserAcceptInfo: isUserAcceptInfo,
              currentLocation: currentLocation,
              experianceType: experianceType,
              handleChangeCurrentLocation: _handleChangeCurrentLocation,
              handleChangeUserAcceptInfo: _handleChangeUserAcceptInfo,
            ),
      },
    );
  }
}
