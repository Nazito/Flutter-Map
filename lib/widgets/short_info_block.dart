import 'package:flutter/material.dart';

class ShortInfoBlock extends StatelessWidget {
  final dynamic currentLocation;

  const ShortInfoBlock({Key? key, required this.currentLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: currentLocation != null
                      ? DecorationImage(
                          image: currentLocation.preview,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            Container(
              width: 150.0,
              margin: const EdgeInsets.only(bottom: 50),
              child: currentLocation != null
                  ? Text(
                      currentLocation!.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  : null,
            ),
          ],
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: currentLocation != null
                  ? Text(
                      currentLocation!.descr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  : null),
        ),
      ],
    );
  }
}
