part of 'top_movies_bloc.dart';

@immutable
abstract class TopMoniesState {}

class TopMoniesInitialState extends TopMoniesState {}

class TopMoniesLoadingState extends TopMoniesState {}

class TopRatedSuccessState extends TopMoniesState {
  // final MovieListModel movies;
  final List<MovieModel> movies;
  TopRatedSuccessState({required this.movies});
}

class TopRatedErrorState extends TopMoniesState {}
