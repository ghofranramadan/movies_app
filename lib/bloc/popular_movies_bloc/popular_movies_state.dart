part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState {}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesSuccessState extends PopularMoviesState {
  final List<MovieModel> popularMovies;
  PopularMoviesSuccessState({required this.popularMovies});
}

class PopularMoviesErrorState extends PopularMoviesState {}
