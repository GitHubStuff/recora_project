import 'package:flutter/material.dart';

const double beatingHeartHeight = 125.0;

class BeatingHeart extends StatelessWidget {
  final double height;
  const BeatingHeart({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        "assets/gifs/love-you-heart.gif",
        height: height,
        width: height,
      );
}
