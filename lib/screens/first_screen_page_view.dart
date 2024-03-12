import 'package:flutter/material.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/intro_screen.dart';

class FirstScreenPageView extends StatelessWidget {
  const FirstScreenPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 1:
              return const IntroScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
