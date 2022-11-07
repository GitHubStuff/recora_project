import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../main.dart';
// ignore: library_prefixes
import '../../models/constants.dart' as K;
import '../../models/failure.dart';
import '../../models/movies.dart';
import '../../networking/network_abstract.dart';

part 'ltwm_state.dart';

const Duration _splashScreenDuration = Duration(seconds: 3);
const Duration _triggerSearchPause = Duration(milliseconds: 1500);
const int _requiredSearchStringLength = 1;

abstract class CubitAbstract {
  void showList();
  void downloadList();
  void refreshList();
  void searchRequest(String searchText);
}

abstract class LtwmCubitAbstract extends Cubit<LtwmState> implements CubitAbstract {
  LtwmCubitAbstract() : super(LtwmInitial());

  @override
  void showList() {
    Future.delayed(_splashScreenDuration, () {
      emit(LtwmShowList());
    });
  }

  @override
  void refreshList() => emit(LtwmShowList());
}

class LtwmCubit extends LtwmCubitAbstract implements CubitAbstract {
  final int _currentPage = 1;
  Timer? _timer;
  String? _lastSearch;

  @override
  void downloadList() async {
    Future.delayed(K.uxDuration, () async {
      emit(LtwmDownloading());
      await popularMovies();
    });
  }

  Future<void> popularMovies() async {
    final NetworkRequests network = Modular.get<NetworkRequests>();
    Either<Failure, Json> result = await network.getPopularMovies(page: _currentPage);
    result.fold((failure) {
      emit(LtwmDownloadFailure(failure));
    }, (json) {
      try {
        Movies movies = Movies.fromJson(json);
        emit(LtwmDownloadComplete(movies));
      } catch (e) {
        emit(LtwmDownloadFailure(Failure(e.toString())));
      }
    });
  }

  @override
  void searchRequest(String searchText) async {
    _timer?.cancel();
    // ignore: void_checks
    _timer = Timer(
      _triggerSearchPause,
      () {
        _performSearch(searchText);
        _lastSearch = searchText;
      },
    );
  }

  Future<void> _performSearch(String searchText) async {
    if (_lastSearch != searchText) {
      if (searchText.isEmpty) popularMovies();
      if (searchText.length > _requiredSearchStringLength) {
        final NetworkRequests network = Modular.get<NetworkRequests>();
        Either<Failure, Json> result = await network.getSearchedMovies(searchText);
        result.fold((failure) {
          emit(LtwmDownloadFailure(failure));
        }, (json) {
          try {
            Movies movies = Movies.fromJson(json);
            emit(LtwmDownloadComplete(movies));
          } catch (e) {
            emit(LtwmDownloadFailure(Failure(e.toString())));
          }
        });
      }
    }
    _lastSearch = searchText;
  }
}
