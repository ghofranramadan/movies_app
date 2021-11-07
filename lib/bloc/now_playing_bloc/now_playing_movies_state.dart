part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoadingState extends NowPlayingMoviesState {}

class NowPlayingMoviesSuccessState extends NowPlayingMoviesState {
  final List<MovieModel> nowPlayingMovies;
  NowPlayingMoviesSuccessState({required this.nowPlayingMovies});
}

class NowPlayingMoviesErrorState extends NowPlayingMoviesState {}
