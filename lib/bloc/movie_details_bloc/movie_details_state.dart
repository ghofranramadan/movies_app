part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  MovieDetailsSuccessState({required this.movieDetails});
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String error;

  MovieDetailsErrorState({required this.error});
}
