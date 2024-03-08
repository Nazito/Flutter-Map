import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';

class ExperienceScreen extends StatefulWidget {
  final void Function(dynamic state) handleChangeExperianceType;

  const ExperienceScreen({
    Key? key,
    required this.handleChangeExperianceType,
  }) : super(key: key);

  @override
  ExperienceScreenState createState() => ExperienceScreenState();
}

class ExperienceScreenState extends State<ExperienceScreen> {
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
                            widget.handleChangeExperianceType("Virtual");
                            Navigator.pushNamed(
                              context,
                              '/map',
                            );
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
                            widget.handleChangeExperianceType("Explore");
                            Navigator.pushNamed(
                              context,
                              '/map',
                            );
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
