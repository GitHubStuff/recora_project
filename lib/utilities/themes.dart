import 'package:flutter/material.dart';

const Color _textColor = Colors.yellow;

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    headline1: TextStyle(color: _textColor, fontSize: 72.0),
    headline2: TextStyle(color: _textColor, fontSize: 60.0),
    headline3: TextStyle(color: _textColor, fontSize: 48.0),
    headline6: TextStyle(color: _textColor, fontSize: 24.0),
  ),
);
