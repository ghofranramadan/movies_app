import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/bloc/now_playing_bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies_app/bloc/top_movies_bloc/top_movies_bloc.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/screens/movie_details.dart';
import 'package:movies_app/widgets/error_layout.dart';
import 'package:movies_app/widgets/movie_widget.dart';
import 'package:paging/paging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const int _count = 5;
  int noOfPage = 1;

  Future<List<MovieModel>> pageData(
      int previousCount, List<MovieModel> moviesModel) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2500));

    List<MovieModel> dummyList = <MovieModel>[];
    //////////////////////////////////////////////////
    if (previousCount < moviesModel.length) {
      for (int i = previousCount; i < previousCount + _count; i++) {
        dummyList.add(moviesModel[i]);
      }
    }
    ////////////////////////////////////////////////
    // else if (previousCount == moviesModel.length) {
    //   setState(() {
    //     noOfPage++;
    //   });
    //   display(noOfPage);
    //   for (int i = previousCount; i < previousCount + _count; i++) {
    //     dummyList.add(moviesModel[i]);
    //   }
    // }

    return dummyList;
  }
//////////////////////////////////////////////////////////////////////////////

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        displayData();
        print('coNNNNNNNNNNNNNNNNNNNNNNNNNNNected');
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: ErrorPopUp(
            title: 'No Connection',
            message: 'Please check internet connection and try again',
            onTap: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });
              // displayData();
            },
          ),
        ),
      );
      print('nOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOt connected');
    }
  }

  void displayData() {
    BlocProvider.of<TopMoviesBloc>(context).add(FetchTopRatedMovies(
      noOfPage: 1,
    ));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    displayData();
    BlocProvider.of<PopularMoviesBloc>(context)
        .add(FetchPopularMovies(noOfPage: 1));
    BlocProvider.of<NowPlayingMoviesBloc>(context)
        .add(FetchNowPlayingMovies(noOfPage: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 35,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                unselectedLabelColor: Theme.of(context).indicatorColor,
                labelStyle: Theme.of(context).textTheme.headline3,
                unselectedLabelStyle: Theme.of(context).textTheme.headline4,
                tabs: const [
                  Tab(text: "Top Movies"),
                  Tab(text: 'Popular'),
                  Tab(text: 'Now Playing'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  BlocConsumer<TopMoviesBloc, TopMoniesState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is TopMoniesLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TopRatedSuccessState) {
                        List<MovieModel> topMovies = state.movies;
                        return RefreshIndicator(
                          onRefresh: () => checkInternetConnection(),
                          child: Pagination<MovieModel>(
                            pageBuilder: (currentSize) =>
                                pageData(currentSize, topMovies),
                            itemBuilder: (index, item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<MovieDetailsBloc>(context)
                                        .add(FetchMovieDetails(
                                            movieId: item.id));

                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MovieDetails();
                                          },
                                        ),
                                      );
                                    });
                                  },
                                  child: MovieWidget(
                                    image: item.posterPath,
                                    title: item.title,
                                    overview: item.overview,
                                    releaseDate: item.releaseDate,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                            onRefresh: () => checkInternetConnection(),
                            child: const Center(child: Text("Error")));
                      }
                    },
                  ),

                  // BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
                  //   listener: (context, state) {},
                  //   builder: (context, state) {
                  //     if (state is PopularMoviesLoadingState) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     } else if (state is PopularMoviesSuccessState) {
                  //       List<MovieModel> popularMovies = state.popularMovies;
                  //       return Pagination<MovieModel>(
                  //         pageBuilder: (currentSize) =>
                  //             pageData(currentSize, popularMovies),
                  //         itemBuilder: (index, item) {
                  //           return Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: MovieWidget(
                  //               onTap: () {},
                  //               image: item.posterPath,
                  //               title: item.title,
                  //               overview: item.overview,
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       return const Center(child: Text("Error"));
                  //     }
                  //   },
                  // ),
                  // BlocConsumer<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                  //   listener: (context, state) {},
                  //   builder: (context, state) {
                  //     if (state is NowPlayingMoviesLoadingState) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     } else if (state is NowPlayingMoviesSuccessState) {
                  //       List<MovieModel> nowPlayingMovies =
                  //           state.nowPlayingMovies;
                  //       return Pagination<MovieModel>(
                  //         pageBuilder: (currentSize) =>
                  //             pageData(currentSize, nowPlayingMovies),
                  //         itemBuilder: (index, item) {
                  //           return Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: MovieWidget(
                  //               onTap: () {},
                  //               image: item.posterPath,
                  //               title: item.title,
                  //               overview: item.overview,
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       return const Center(child: Text("Error"));
                  //     }
                  //   },
                  // ),
                  //
                  const Center(child: Text('data1')),
                  const Center(child: Text('data2')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
