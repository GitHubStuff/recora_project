part of 'ltwm_cubit.dart';

@immutable
abstract class LtwmState {}

class LtwmInitial extends LtwmState {}

class LtwmShowList extends LtwmState {}

class LtwmDownloading extends LtwmState {}

class LtwmDownloadComplete extends LtwmState {
  final Movies movies;
  LtwmDownloadComplete(this.movies);
}

class LtwmDownloadFailure extends LtwmState {
  final Failure failure;
  LtwmDownloadFailure(this.failure);
}
