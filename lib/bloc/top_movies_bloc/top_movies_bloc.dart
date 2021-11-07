import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_connect.dart';
import 'package:movies_app/model/movie_model.dart';

part 'top_movies_event.dart';
part 'top_movies_state.dart';

class TopMoviesBloc extends Bloc<TopMoviesEvent, TopMoniesState> {
  TopMoviesBloc() : super(TopMoniesInitialState());

  List<MovieModel> topMovies = [];
  late MovieListModel movieListModel;

  int currentPage = 1;
  late int totalPages;

  @override
  Stream<TopMoniesState> mapEventToState(TopMoviesEvent event) async* {
    if (event is FetchTopRatedMovies) {
      yield* fetchTopRatedMovies(event);
    }
  }

  Stream<TopMoniesState> fetchTopRatedMovies(FetchTopRatedMovies event) async* {
    try {
      yield TopMoniesLoadingState();

      var response = await ApiProvider.getApiData(
        url: API.topRated,
        noOfPage: event.noOfPage,
      );

      if (ApiProvider.validResponse(response.statusCode)) {
        movieListModel = MovieListModel.fromJson(
          response.data,
        );

        totalPages = movieListModel.totalPages;

        movieListModel.movies.forEach((e) {
          topMovies.add(e);
        });
        yield TopRatedSuccessState(movies: topMovies);
      } else {
        throw response.data;
      }
    } catch (e) {
      print("Error ==> $e");
      yield TopRatedErrorState(
        error: e.toString(),
      );
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////

}
