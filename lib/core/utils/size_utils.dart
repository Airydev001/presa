import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const num DESIGN_WIDTH = 375;
const num DESIGN_HEIGHT = 812;
const num DESIGN_STATUSBAR = 0;

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

class Sizer extends StatelessWidget {
  const Sizer({
    super.key,
    required this.builder,
  });
//Builds the widget whenever the orientation changes;
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
//Device BoxConstraints
  static late BoxConstraints boxConstraints;

//Device's Orientation;
  static late Orientation orientation;

  ///Type of Device
  ///
  ///This can be either mobile or tablet
  static late DeviceType deviceType;

  static late double height;

//Device width
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonzero(defaultValue: DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonzero();
    } else {
      width = boxConstraints.maxHeight.isNonzero(defaultValue: DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonzero();
    }
    deviceType = DeviceType.mobile;
  }
}

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;

  double get _height => SizeUtils.height;

  double get h => ((this * _width) / DESIGN_WIDTH);

  double get v => (this * _height) / (DESIGN_HEIGHT - DESIGN_STATUSBAR);

  ///This method is used to set smallest px in image height
  double get adaptSize {
    var height = v;

    var width = h;

    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  //This method is used to set text font size according to View
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  ///Return a [] value with formatted according to provided FractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonzero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType {
  mobile,
  tablet,
  desktop,
}
