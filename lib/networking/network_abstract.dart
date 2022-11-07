import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/failure.dart';

abstract class NetworkRequests {
  NetworkRequests({required String appId});
  Future<Either<Failure, Json>> getPopularMovies({int page});
  Future<Either<Failure, Json>> getSearchedMovies(String searchText);
  Widget getPosterImage({required double height, required String? url});
}
