import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/utilities/extensions/widget_extensions.dart';
import 'package:recora/utilities/themes.dart';

// ignore: library_prefixes
import '../models/constants.dart' as K;
import '../models/movies.dart';
import '../networking/network_abstract.dart';

const double _largePosterHeight = 400.0;

class DetailWidget extends StatelessWidget {
  final Results movie;
  const DetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (K.isTablet(context) && movie.title != null) _movieTitle(movie.title!),
            _moviePoster(),
            _releaseDate(),
            _summary(),
          ],
        ),
      ),
    );
  }

  Widget _moviePoster() {
    final NetworkRequests networkRequest = Modular.get<NetworkRequests>();
    final String? path = movie.posterPath;
    return networkRequest.getPosterImage(
      height: _largePosterHeight,
      url: path,
    );
  }

  Text _releaseDate() => Text('Release Date: ${movie.releaseDate ?? 'Unknown'}\nScore: ${movie.voteAverage}');

  Text _movieTitle(String title) => Text(
        title,
        style: darkTheme.textTheme.headline3,
      );

  Widget _summary() => Text(
        movie.overview ?? 'No Summary',
        style: darkTheme.textTheme.subtitle1,
      ).paddingAll(K.defaultPadding).borderAll(Colors.yellow).paddingAll(K.defaultPadding);
}
