import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/api/api_connect.dart';
import 'package:movies_app/model/movie_details_model.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial());

  late MovieDetailsModel movieDetails;

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is FetchMovieDetails) {
      yield* fetchMovieDetails(event);
    }
  }

  Stream<MovieDetailsState> fetchMovieDetails(FetchMovieDetails event) async* {
    try {
      yield MovieDetailsLoadingState();
      var response = await ApiProvider.getApiData(
        url: event.movieId.toString(),
      );
      if (ApiProvider.validResponse(response.statusCode)) {
        movieDetails = MovieDetailsModel.fromJson(
          response.data,
        );

        yield MovieDetailsSuccessState(
          movieDetails: movieDetails,
        );
      } else {
        throw response.data;
      }
    } catch (e) {
      print("Error ==> $e");
      yield MovieDetailsErrorState(
        error: e.toString(),
      );
    }
  }
}
