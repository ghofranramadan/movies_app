part of 'top_movies_bloc.dart';

@immutable
abstract class TopMoviesEvent {}

class FetchTopRatedMovies extends TopMoviesEvent {
  final int noOfPage;

  FetchTopRatedMovies({required this.noOfPage});
}
