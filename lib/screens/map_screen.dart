import 'package:flutter/material.dart';
import 'package:my_app/widgets/carousel.dart';
import 'package:my_app/widgets/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:my_app/widgets/map_google.dart';
import 'package:my_app/widgets/short_info_block.dart';
import 'package:my_app/widgets/full_info_block.dart';
import 'package:my_app/widgets/menu.dart';

import '../additionals/location.dart';
import '../utils/constants.dart';

class MapScreen extends StatefulWidget {
  final void Function(dynamic state) handleChangeCurrentLocation;
  final void Function(dynamic state) handleChangeUserAcceptInfo;
  final List<Location> locations;
  final Location? currentLocation;
  final String? experianceType;
  final bool isUserAcceptInfo;

  const MapScreen({
    Key? key,
    required this.handleChangeCurrentLocation,
    required this.handleChangeUserAcceptInfo,
    required this.locations,
    required this.currentLocation,
    required this.experianceType,
    required this.isUserAcceptInfo,
  }) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  PanelController panelController = PanelController();
  double previousPosition = 0.0;
  bool isClosed = false;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCarouselModal(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0;
    final panelHeightOpen = MediaQuery.of(context).size.height * 1;

    // double panelSnapPosition = 0.0;
    // ====================

    return Stack(children: [
      Scaffold(
          body: SafeArea(
        top: true,
        child: SlidingUpPanel(
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          parallaxEnabled: false,
          controller: panelController,
          color: themeOverlayColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          onPanelSlide: _snapPointPanel,
          panelSnapping: false,
          snapPoint: 0.5,
          backdropEnabled: true,
          backdropTapClosesPanel: true,
          panelBuilder: (controller) => PanelWidget(
              controller: controller, panelController: panelController),
          panel: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                // Close Icons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 30.0,
                      onPressed: () {
                        _closePanel();
                        if (widget.currentLocation != null &&
                            widget.experianceType == "Virtual") {
                          final currentIndex =
                              widget.locations.indexOf(widget.currentLocation!);
                          if (currentIndex < widget.locations.length - 1) {
                            widget.handleChangeCurrentLocation(
                                widget.locations[currentIndex + 1]);
                          }
                        }
                      },
                    ),
                  ],
                ),
                // Full height block
                Visibility(
                    visible: previousPosition > 0.5,
                    child: FullInfoBlock(
                        locations: widget.locations,
                        currentLocation: widget.currentLocation,
                        handleChangeCurrentLocation:
                            widget.handleChangeCurrentLocation,
                        closePanel: _closePanel,
                        experianceType: widget.experianceType)),
                // Min height block
                Visibility(
                    visible: previousPosition <= 0.5,
                    child: ShortInfoBlock(
                        currentLocation: widget.currentLocation)),
              ])),
          body: Center(
            child: MapGoogle(
                isUserAcceptInfo: widget.isUserAcceptInfo,
                handleChangeCurrentLocation: widget.handleChangeCurrentLocation,
                experianceType: widget.experianceType,
                currentLocation: widget.currentLocation,
                togglePanel: _togglePanel,
                locations: widget.locations),
          ),
        ),
      )),
      Positioned(
        left: 25.0,
        bottom: 80.0,
        child: FloatingActionButton(
          onPressed: () {
            _showMenuModal(context);
          },
          child: const Icon(Icons.menu),
        ),
      ),
    ]);
  }

  void _closePanel() => {
        isClosed = true,
        if (panelController.isAttached) {panelController.close()}
      };

  void _togglePanel(double position) {
    if (panelController.isAttached) {
      panelController.animatePanelToPosition(position);
    }
  }

  void _snapPointPanel(double pos) {
    if (panelController.isAttached &&
        !isClosed &&
        widget.experianceType == "Explore") {
      if (pos > previousPosition) {
        // Панель движется вверх
        if (pos < 0.5) {
          panelController.animatePanelToSnapPoint();
        }
      }
      if (pos < previousPosition) {
        // Панель движется вниз
        if (pos > 0.5) {
          panelController.animatePanelToSnapPoint();
        }
      }
    }
    setState(() {
      previousPosition = pos;
    });

    if (pos == 0.0) {
      isClosed = false;
    }
  }

  void _showMenuModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2), // Полупрозрачный цвет фона
            ),
            child: const Menu());
      },
    );
  }

  void _showCarouselModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2), // Полупрозрачный цвет фона
          ),
          child: Carousel(
              handleCangeUserAcceptInfo: widget.handleChangeUserAcceptInfo,
              handleChangeCurrentLocation: widget.handleChangeCurrentLocation,
              experianceType: widget.experianceType,
              locations: widget.locations),
        );
      },
    );
  }
}
