import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/main.dart';
import 'package:my_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({
    Key? key,
  }) : super(key: key);

  @override
  ExperienceScreenState createState() => ExperienceScreenState();
}

class ExperienceScreenState extends State<ExperienceScreen> {
  late AppState appState;

  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: themeSecondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Text(
                          "Chose your experiance",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(double.infinity, 70),
                            backgroundColor: themeBgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            appState.changeExperianceType("Virtual");
                            GoRouter.of(context).go('/map');
                          },
                          child: Text(
                            'Virtual Tour',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(double.infinity, 70),
                            backgroundColor: themeBgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            appState.changeExperianceType("Explore");
                            GoRouter.of(context).go('/map');
                          },
                          child: Text(
                            'Explore',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Navigate to different locations at your own pace, in your own order.',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        )),
                  ],
                ))),
      ),
    );
  }
}
