import 'package:flutter/material.dart';

bool isTablet(BuildContext context) {
  final double shortestSide = MediaQuery.of(context).size.shortestSide;
  final double aspectRatio = MediaQuery.of(context).size.aspectRatio;
  return shortestSide > 600 && aspectRatio < 1.6;
}

class DeviceLayout extends StatelessWidget {
  final Widget phoneView;
  final Widget tabletView;

  const DeviceLayout(
      {required this.phoneView, required this.tabletView, super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape || isTablet(context)) {
        return tabletView;
      } else {
        return phoneView;
      }
    });
  }
}
