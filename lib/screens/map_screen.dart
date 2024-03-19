import 'package:flutter/material.dart';
import 'package:my_app/additionals/locations_list.dart';
import 'package:my_app/main.dart';
import 'package:my_app/widgets/carousel.dart';
import 'package:my_app/widgets/locations_carousel.dart';
import 'package:my_app/widgets/map_box_gl.dart';
import 'package:my_app/widgets/panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:my_app/widgets/short_info_block.dart';
import 'package:my_app/widgets/full_info_block.dart';
import 'package:my_app/widgets/menu.dart';

import '../additionals/location.dart';
import '../utils/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late AppState appState;
  PanelController panelController = PanelController();
  double previousPosition = 0.0;
  bool isClosed = false;
  final List<Location> locations = LocationList.locations;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCarouselModal(context);
    });
    appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0;
    final panelHeightOpen = MediaQuery.of(context).size.height * 1;

    // double panelSnapPosition = 0.0;
    // ====================

    return Stack(children: [
      Scaffold(
        body: SlidingUpPanel(
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          parallaxEnabled: false,
          controller: panelController,
          color: themeOverlayColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          onPanelSlide: _snapPointPanel,
          panelSnapping: true,
          snapPoint: 0.5,
          backdropEnabled: true,
          backdropTapClosesPanel: true,
          boxShadow: null,
          panelBuilder: (controller) => PanelWidget(
              controller: controller, panelController: panelController),
          panel: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                // Close Icons
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          iconSize: 30.0,
                          onPressed: () {
                            _closePanel();
                            if (appState.currentLocation != null &&
                                appState.experianceType == "Virtual") {
                              final currentIndex =
                                  locations.indexOf(appState.currentLocation!);
                              if (currentIndex < locations.length - 1) {
                                appState.changeCurrentLocation(
                                    locations[currentIndex + 1]);
                              }
                            }
                          },
                        )),
                  ],
                ),
                // Full height block
                Visibility(
                    visible: previousPosition > 0.5 + 0.01,
                    child: FullInfoBlock(
                      closePanel: _closePanel,
                    )),
                // Min height block
                Visibility(
                    visible: previousPosition <= 0.5,
                    child: const ShortInfoBlock()),
              ])),
          body: MapBoxGl(
              togglePanel: _togglePanel, panelPosition: previousPosition),
        ),
      ),
      Positioned(
        left: 25.0,
        bottom: 80.0,
        child: FloatingActionButton(
          backgroundColor: themeSecondaryColor,
          onPressed: () {
            _showMenuModal(context);
          },
          child: const Icon(Icons.menu),
        ),
      ),
      Positioned(
        right: 25.0,
        left: 100.0,
        bottom: 50.0,
        child: LocationsCarousel(togglePanel: _togglePanel),
      ),
    ]);
  }

  void _closePanel() => {
        isClosed = true,
        if (panelController.isAttached)
          {panelController.animatePanelToPosition(0)}
      };

  void _togglePanel(double position) {
    if (panelController.isAttached) {
      panelController.animatePanelToPosition(position);
    }
  }

  void _snapPointPanel(double pos) {
    if (panelController.isAttached &&
        !isClosed &&
        appState.experianceType == "Explore") {
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
              color: Colors.black.withOpacity(0.2),
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
            color: Colors.black.withOpacity(0.2),
          ),
          child: const Carousel(),
        );
      },
    );
  }
}
