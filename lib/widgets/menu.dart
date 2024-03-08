import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Menu",
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
                  Navigator.pop(context);
                },
                child: Text(
                  'Discover RBD',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: themePrimaryColor,
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   '/map',
                  // );
                },
                child: Text(
                  'About the Project',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 70),
              backgroundColor: themeBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              textStyle: TextStyle(
                fontSize: 20,
                color: themePrimaryColor,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/experience',
              );
            },
            child: Text(
              'Switch Experiences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    )));
  }
}
