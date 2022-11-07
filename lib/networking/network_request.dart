import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/failure.dart';
import 'network_abstract.dart';

const String _popularMovies = 'https://api.themoviedb.org/3/movie/popular?api_key=&language=en-US&page=';
const String _searchMovies = 'https://api.themoviedb.org/3/search/movie?api_key=&language=en-US&query=&page=1&include_adult=false';
const String _posterURL = 'https://image.tmdb.org/t/p/w500';
const int _networkSuccess = 200;

class NetworkRequest implements NetworkRequests {
  late final String _appId;
  NetworkRequest({required String appId}) {
    _appId = appId;
  }

  @override
  Future<Either<Failure, Json>> getSearchedMovies(String searchText) async {
    String urlString = _searchMovies.replaceAll('api_key=', 'api_key=$_appId').replaceAll('query=', 'query=$searchText');
    late http.Response networkResponse;
    try {
      var uri = Uri.parse(urlString);
      networkResponse = await http.get(uri);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
    return parseResponse(networkResponse);
  }

  @override
  Future<Either<Failure, Json>> getPopularMovies({int page = 1}) async {
    String urlString = _popularMovies.replaceAll('api_key=', 'api_key=$_appId').replaceAll('page=', 'page=$page');
    late http.Response networkResponse;
    try {
      var uri = Uri.parse(urlString);
      networkResponse = await http.get(uri);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
    return parseResponse(networkResponse);
  }

  Either<Failure, Json> parseResponse(http.Response response) {
    switch (response.statusCode) {
      case _networkSuccess:
        var decode = jsonDecode(utf8.decode(response.bodyBytes)) as Json;
        return Right(decode);
      default:
        return Left(Failure('${response.statusCode}'));
    }
  }

  @override
  Widget getPosterImage({required double height, required String? url}) {
    if (url == null || url.isEmpty) {
      return SizedBox(height: height);
    }
    url = '$_posterURL$url';
    return SizedBox(
      height: height,
      child: CachedNetworkImage(
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: url,
      ),
    );
  }
}
