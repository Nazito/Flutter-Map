import 'package:flutter/material.dart';

class NamedRoutes extends StatelessWidget {
  const NamedRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/intro': (context) => const IntroScreen(),
        '/experience': (context) => const ExperienceScreen(),
        '/map': (context) => const MapScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(
            //   'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=904&hei=840&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1587460552755',
            //   width: 200,
            // ),
            ElevatedButton(
              child: const Text('Подробнее'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/intro',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: const [
                  ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Intro Screen'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Назад'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('experience'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/experience',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: const [
                  ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Experience Screen'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Назад'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('map'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/map',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: const [
                  ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Map'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Назад'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
