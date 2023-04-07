import 'package:flutter/material.dart';

// import './screens/anonymous_routes.dart';
import './screens/named_routes.dart';

void main() {
  // runApp(const AnonymousRoutes());
  runApp(const NamedRoutes());
}




// import 'package:flutter/material.dart';

// void main() => runApp(const ScreenWidget());

// class ScreenWidget extends StatelessWidget {
//   const ScreenWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//           // appBar: AppBar(title: const Text('StatefulWidget')),
//           body: SimpleWidget()),
//     );
//   }
// }

// ============= StatefulWidget Example

// class SimpleWidget extends StatefulWidget {
//   const SimpleWidget({super.key});

//   @override
//   SimpleWidgetState createState() => SimpleWidgetState();
// }

// class SimpleWidgetState extends State<SimpleWidget> {
//   int _count = 0;
//   void _handleButton() {
//     setState(() {
//       _count++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text('$_count'),
//         ElevatedButton(
//             onPressed: () {
//               _handleButton();
//             },
//             child: const Text('Click me'))
//       ],
//     ));
//   }
// }

// ============= StatelessWidget Example

// class SimpleWidget extends StatelessWidget {
//   const SimpleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Container(
//             // color: Colors.green,
//             width: double.infinity,
//             height: 300,
//             alignment: Alignment.center,
//             margin: const EdgeInsets.all(50),
//             padding: const EdgeInsets.all(50),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(color: Colors.yellow, width: 2),
//               image: DecorationImage(
//                   image: Image.network(
//                           'https://mobimg.b-cdn.net/v3/fetch/70/703e3aefd9500eff0f63294bc383ac2a.jpeg?w=600&r=0.5625')
//                       .image,
//                   fit: BoxFit.cover),
//             ),
//             child: const Text('Panda',
//                 style: TextStyle(fontSize: 40, color: Colors.white))));
//   }
// }

// ============= Column Example

// class SimpleWidget extends StatelessWidget {
//   const SimpleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       children: const <Widget>[TextWidget(text: 'first')],
//     ));
//   }
// }

// class TextWidget extends StatelessWidget {
//   const TextWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       children: const <Widget>[TextWidget(text: 'first')],
//     ));
//   }
// }
