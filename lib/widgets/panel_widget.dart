import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   'Black Dallas Historical Map Experience',
    //   style: Theme.of(context).textTheme.headlineLarge,
    //   textAlign: TextAlign.center,
    // );

    Widget buildeDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(10),
              width: 30,
              height: 25,
              decoration: BoxDecoration(color: Colors.grey[300])),
        ));

    return ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: [buildeDragHandle()]);
  }

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
