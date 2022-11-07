import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/utilities/extensions/widget_extensions.dart';
import 'package:recora/utilities/themes.dart';

// ignore: library_prefixes
import '../models/constants.dart' as K;
import '../models/movies.dart';
import '../networking/network_abstract.dart';

const double _largePosterHeight = 400.0;

class DetailScreen extends StatelessWidget {
  static const route = '/DetailScreen';
  final Results result;
  const DetailScreen({super.key, required this.result});

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
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _moviePoster(),
                _releaseDate(),
                _summary(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _moviePoster() {
    final NetworkRequests networkRequest = Modular.get<NetworkRequests>();
    final String? path = result.posterPath;
    return networkRequest.getPosterImage(
      height: _largePosterHeight,
      url: path,
    );
  }

  Text _releaseDate() => Text('Release Date: ${result.releaseDate ?? 'Unknown'}\nScore: ${result.voteAverage}');

  Text _title1() => Text(
        result.title ?? '<NO TITLE>',
        style: darkTheme.textTheme.headline4,
      );

  Widget _summary() => Text(
        result.overview ?? 'No Summary',
        style: darkTheme.textTheme.subtitle1,
      ).paddingAll(K.defaultPadding).borderAll(Colors.yellow).paddingAll(K.defaultPadding);
}
