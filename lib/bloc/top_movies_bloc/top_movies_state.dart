part of 'top_movies_bloc.dart';

@immutable
abstract class TopMoniesState {}

class TopMoniesInitialState extends TopMoniesState {}

class TopMoniesLoadingState extends TopMoniesState {}

class TopRatedSuccessState extends TopMoniesState {
  final List<MovieModel> movies;
  TopRatedSuccessState({required this.movies});
}

class TopRatedErrorState extends TopMoniesState {
  final String error;
  TopRatedErrorState({required this.error});
}
