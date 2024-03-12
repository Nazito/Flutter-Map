import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/screens/first_screen_page_view.dart';
import 'package:provider/provider.dart';
import 'package:my_app/additionals/location.dart';
import 'package:my_app/screens/experience_screen.dart';
import 'package:my_app/screens/map_screen.dart';
import 'package:my_app/utils/theme.dart';

void main() {
  runApp(const App());
}

// / The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const FirstScreenPageView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'experience',
          builder: (BuildContext context, GoRouterState state) {
            return const ExperienceScreen();
          },
        ),
        GoRoute(
          path: 'map',
          builder: (BuildContext context, GoRouterState state) {
            return const MapScreen();
          },
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp.router(
        routerConfig: _router,
        theme: basicTheme(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  Location? currentLocation;
  String? experianceType;
  bool isUserAcceptInfo = false;

  void changeCurrentLocation(Location loc) {
    currentLocation = loc;
    notifyListeners();
  }

  void changeExperianceType(type) {
    experianceType = type;
    notifyListeners();
  }

  changeUserAcceptInfo(status) {
    isUserAcceptInfo = status;
    notifyListeners();
  }
}
