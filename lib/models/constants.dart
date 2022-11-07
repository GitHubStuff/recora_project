import 'package:flutter/material.dart';

const Duration uxDuration = Duration(milliseconds: 300);
const double defaultPadding = 8.0;
const double animationHeight = 125.0;

bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
