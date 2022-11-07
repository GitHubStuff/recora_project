import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/movies.dart';
import '../networking/network_abstract.dart';
import '../utilities/cubit/ltwm_cubit.dart';

const double _posterThumbnailHeight = 100.0;

class MovieCard extends StatelessWidget {
  final Results movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _moviePoster(),
        title: _title(),
        subtitle: _subTitle(),
        isThreeLine: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          final LtwmCubitAbstract cubit = Modular.get<LtwmCubitAbstract>();
          cubit.showMovieDetails(movie);
        },
      ),
    );
  }

  Widget _moviePoster() {
    final NetworkRequests networkRequest = Modular.get<NetworkRequests>();
    final String? path = movie.posterPath;
    return networkRequest.getPosterImage(height: _posterThumbnailHeight, url: path);
  }

  Text _title() => Text(movie.title ?? '');
  Text _subTitle() => Text('Release Date: ${movie.releaseDate ?? 'Unknown'}\nScore: ${movie.voteAverage}');
}
