import 'package:flutter/material.dart';

class ResizerData {
  final double resizerWidth;
  final Decoration? decoration;
  final Color iconColor, resizerColor, resizerHoverColor;

  const ResizerData({
    this.decoration,
    this.resizerWidth = 3,
    this.iconColor = Colors.black,
    this.resizerColor = Colors.black12,
    this.resizerHoverColor = Colors.blue,
  }) : assert(resizerWidth >= 0.0);
}
