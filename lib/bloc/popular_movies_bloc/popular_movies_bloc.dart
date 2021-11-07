import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_connect.dart';
import 'package:movies_app/model/movie_model.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc() : super(PopularMoviesInitialState());

  List<MovieModel> popularMovies = [];
  late MovieListModel movieListModel;

  int currentPage = 1;
  late int totalPages;
  @override
  Stream<PopularMoviesState> mapEventToState(PopularMoviesEvent event) async* {
    if (event is FetchPopularMovies) {
      yield* fetchPopularMovies(event);
    }
  }

  Stream<PopularMoviesState> fetchPopularMovies(
      FetchPopularMovies event) async* {
    try {
      yield PopularMoviesLoadingState();
      var response = await ApiProvider.getApiData(
        url: API.popular,
        noOfPage: event.noOfPage,
      );

      if (ApiProvider.validResponse(response.statusCode)) {
        movieListModel = MovieListModel.fromJson(
          response.data,
        );

        totalPages = movieListModel.totalPages;

        movieListModel.movies.forEach((e) {
          popularMovies.add(e);
        });
        yield PopularMoviesSuccessState(popularMovies: popularMovies);
      } else {
        throw response.data;
      }
    } catch (e) {
      print("Error ==> $e");
      yield PopularMoviesErrorState(
        error: e.toString(),
      );
    }
  }
}
