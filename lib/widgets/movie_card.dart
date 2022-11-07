import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// ignore: library_prefixes
import '../models/constants.dart' as K;
import '../models/movies.dart';
import '../networking/network_abstract.dart';
import '../screens/detail_screen.dart';

const double _posterThumbnailHeight = 100.0;

class MovieCard extends StatelessWidget {
  final Results result;
  const MovieCard({super.key, required this.result});

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
          Future.delayed(K.uxDuration, () {
            Modular.to.pushNamed(DetailScreen.route, arguments: result);
          });
          //
        },
      ),
    );
  }

  Widget _moviePoster() {
    final NetworkRequests networkRequest = Modular.get<NetworkRequests>();
    final String? path = result.posterPath;
    return networkRequest.getPosterImage(height: _posterThumbnailHeight, url: path);
  }

  Text _title() => Text(result.title ?? '');
  Text _subTitle() => Text('Release Date: ${result.releaseDate ?? 'Unknown'}\nScore: ${result.voteAverage}');
}
