part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesEvent {}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  final int noOfPage;

  FetchNowPlayingMovies({required this.noOfPage});
}
