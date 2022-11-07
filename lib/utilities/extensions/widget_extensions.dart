import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget background(Color color) => DecoratedBox(
        decoration: BoxDecoration(
          color: color,
        ),
        child: this,
      );

  Widget borderAll(
    Color color, {
    double width = 1.5,
    double radius = 0.0,
  }) =>
      Container(
        decoration: BoxDecoration(border: Border.all(color: color, width: width), borderRadius: BorderRadius.circular(radius)),
        child: this,
      );

  Widget hide(bool state) => opacity(state ? 0.0 : 1.0);

  Widget opacity(double shade) {
    assert(shade >= 0.0 && shade <= 1.0);
    return Opacity(opacity: shade, child: this);
  }

  Widget padding({double left = 0.0, double right = 0.0, double top = 0.0, double bottom = 0.0}) =>
      Padding(padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: this);

  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this);

  Widget removed(bool state) => state ? const SizedBox(height: 1.0, width: 1.0) : this;

  Widget wrap({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    Color color = Colors.transparent,
  }) =>
      Container(
        color: color,
        child: Padding(padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: this),
      );

  Widget wrapAll(double value, {Color color = Colors.transparent}) => wrap(
        left: value,
        right: value,
        top: value,
        bottom: value,
        color: color,
      );
}
