import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Padding lowPadding() =>
      Padding(padding: const EdgeInsets.all(8), child: this);
  Padding normalPadding() =>
      Padding(padding: const EdgeInsets.all(16), child: this);
  Padding highPadding() =>
      Padding(padding: const EdgeInsets.all(24), child: this);
  Padding horizontalLowPadding() =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding horizontalNormalPadding() =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);
  Padding horizontalHighPadding() =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: this);
  Padding verticalLowPadding() =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding verticalNormalPadding() =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);
  Padding verticalHighPadding() =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: this);
  Padding allPadding(double val) =>
      Padding(padding: EdgeInsets.all(val), child: this);
  Padding horizontalPadding(double val) => Padding(
        padding: EdgeInsets.symmetric(horizontal: val),
        child: this,
      );
  Padding verticalPadding(double val) =>
      Padding(padding: EdgeInsets.symmetric(vertical: val), child: this);
  Padding topPadding(double val) =>
      Padding(padding: EdgeInsets.only(top: val), child: this);
  Padding bottomPadding(double val) =>
      Padding(padding: EdgeInsets.only(bottom: val), child: this);
  Padding leftPadding(double val) =>
      Padding(padding: EdgeInsets.only(left: val), child: this);
  Padding rightPadding(double val) =>
      Padding(padding: EdgeInsets.only(right: val), child: this);
  Padding symmetricalPadding(
          {required double horizontal, required double vertical}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );
  Padding onlyPadding(
          {double left = 0,
          double right = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );
  ClipRRect radiusAll(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  ClipRRect radiusOnly(
          {double topLeft = 0,
          double topRight = 0,
          double bottomLeft = 0,
          double bottomRight = 0}) =>
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight)),
        child: this,
      );
}
