import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_connect.dart';
import 'package:movies_app/model/movie_model.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  NowPlayingMoviesBloc() : super(NowPlayingMoviesInitial());

  List<MovieModel> nowPlayingMovies = [];
  late MovieListModel movieListModel;

  int currentPage = 1;
  late int totalPages;

  @override
  Stream<NowPlayingMoviesState> mapEventToState(
      NowPlayingMoviesEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield* fetchNowPlayingMovies(event);
    }
  }

  Stream<NowPlayingMoviesState> fetchNowPlayingMovies(
      FetchNowPlayingMovies event) async* {
    try {
      yield NowPlayingMoviesLoadingState();
      var response = await ApiProvider.getApiData(
        url: API.nowPlaying,
        noOfPage: event.noOfPage,
      );
      if (ApiProvider.validResponse(response.statusCode)) {
        movieListModel = MovieListModel.fromJson(
          response.data,
        );

        totalPages = movieListModel.totalPages;

        movieListModel.movies.forEach((e) {
          nowPlayingMovies.add(e);
        });
        yield NowPlayingMoviesSuccessState(nowPlayingMovies: nowPlayingMovies);
      } else {
        throw response.data;
      }
    } catch (e) {
      print("Error ==> $e");
      yield NowPlayingMoviesErrorState(
        error: e.toString(),
      );
    }
  }
}
