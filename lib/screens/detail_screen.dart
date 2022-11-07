import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/utilities/themes.dart';
import 'package:recora/widgets/detail_widget.dart';

import '../models/movies.dart';

class DetailScreen extends StatelessWidget {
  static const route = '/DetailScreen';
  final Results movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Modular.to.pop(),
            ),
            title: _title1(),
          ),
          body: DetailWidget(movie: movie)),
    );
  }

  Text _title1() => Text(
        movie.title ?? '<NO TITLE>',
        style: darkTheme.textTheme.headline4,
      );
}
