import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:provider/provider.dart';

class ShortInfoBlock extends StatelessWidget {
  const ShortInfoBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: true);
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
                  image: appState.currentLocation?.preview != null
                      ? DecorationImage(
                          image: appState.currentLocation!.preview,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            Container(
              width: 150.0,
              margin: const EdgeInsets.only(bottom: 50),
              child: appState.currentLocation != null
                  ? Text(
                      appState.currentLocation!.name,
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
              child: appState.currentLocation != null
                  ? Text(
                      appState.currentLocation!.descr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )
                  : null),
        ),
      ],
    );
  }
}
