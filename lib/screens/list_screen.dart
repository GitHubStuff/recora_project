import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/utilities/extensions/widget_extensions.dart';
import 'package:recora/utilities/themes.dart';
import 'package:recora/widgets/detail_widget.dart';
import 'package:recora/widgets/no_movies_card.dart';

// ignore: library_prefixes
import '../models/constants.dart' as K;
import '../models/movies.dart';
import '../utilities/cubit/ltwm_cubit.dart';
import '../widgets/beating_heart.dart';
import '../widgets/movie_card.dart';
import '../widgets/network_error_card.dart';
import '../widgets/search_widget.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  static const route = '/ListScreen';
  ListScreen({super.key});
  final LtwmCubitAbstract cubit = Modular.get<LtwmCubitAbstract>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: Scaffold(body: K.isTablet(context) ? _dynamicSize() : _movieList(isTablet: false)),
    );
  }

  Widget _dynamicSize() {
    return Row(
      children: [
        Flexible(flex: 1, child: _movieList(isTablet: true)),
        Flexible(flex: 3, child: _movieDetail()),
      ],
    );
  }

  Widget _movieDetail() {
    return BlocBuilder<LtwmCubitAbstract, LtwmState>(
        bloc: cubit,
        buildWhen: (_, state) {
          return (state is LtwmShowMovieDetails);
        },
        builder: (context, state) {
          if (state is LtwmShowMovieDetails) {
            Results movie = state.details;
            return DetailWidget(movie: movie);
          }
          return const Center(child: Text(' --- '));
        });
  }

  Widget _movieList({required bool isTablet}) => BlocBuilder<LtwmCubitAbstract, LtwmState>(
        bloc: cubit,
        buildWhen: (_, state) {
          if (state is LtwmShowMovieDetails) {
            if (!isTablet) {
              Results movie = state.details;
              Future.delayed(K.uxDuration, () {
                Modular.to.pushNamed(DetailScreen.route, arguments: movie);
              });
            }
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is LtwmShowList) {
            cubit.downloadList();
          }
          if (state is LtwmDownloading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BeatingHeart(height: K.animationHeight),
                  _downloading(),
                ],
              ),
            );
          }
          if (state is LtwmDownloadComplete) {
            return _searchList(state.movies);
          }

          if (state is LtwmDownloadFailure) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  _caption(),
                  ElevatedButton(
                    child: NetworkErrorCard(
                      failure: state.failure,
                    ),
                    onPressed: () {
                      Future.delayed(K.uxDuration, () => Modular.get<LtwmCubitAbstract>().refreshList());
                    },
                  ),
                  const Spacer(),
                ],
              ).paddingAll(K.defaultPadding),
            );
          }
          return Container();
        },
      );

  Widget _searchList(Movies movies) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchWidget(),
          Expanded(child: _displayMovies(movies)),
          Container(),
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _search(),
        const Expanded(child: SearchWidget()),
      ],
    );
  }

  Widget _displayMovies(Movies movies) {
    final int movieCount = movies.results?.length ?? 0;
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(K.uxDuration, () => Modular.get<LtwmCubitAbstract>().refreshList());
      },
      child: (movieCount == 0)
          ? ListView(
              children: [NoMoviesCard(title: _noMovies())],
            )
          : ListView.builder(
              itemCount: movieCount,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) => MovieCard(movie: movies.results![index]),
            ),
    );
  }

  Text _downloading() => Text(
        'Downloading...',
        style: darkTheme.textTheme.headline5,
      );

  Text _caption() => Text(
        '🚫 Network Error',
        style: darkTheme.textTheme.headline3,
      );

  Text _search() => const Text('Search: ');

  Text _noMovies() => const Text('No Movies');
}
