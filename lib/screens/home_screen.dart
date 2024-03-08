import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';

import 'intro_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction > 0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const IntroScreen()));
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Lorem ipsum dolor sit amet',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    'Swipe left to begin',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.swipe_left_alt,
                    color: themePrimaryColor,
                    size: 70.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
