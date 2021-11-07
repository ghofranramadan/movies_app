import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/bloc/now_playing_bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies_app/bloc/top_movies_bloc/top_movies_bloc.dart';
import 'package:movies_app/model/movie_model.dart';
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

  final _pagingController = PagingController<int, MovieModel>(
    // 2
    firstPageKey: 1,
  );
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<TopMoviesBloc>(context).add(FetchTopRatedMovies(
        // noOfPage: 1,
        noOfPage: pageKey,
      ));
    });

    BlocProvider.of<TopMoviesBloc>(context).add(FetchTopRatedMovies(
      noOfPage: 1,
    ));
    BlocProvider.of<PopularMoviesBloc>(context)
        .add(FetchPopularMovies(noOfPage: 1));
    BlocProvider.of<NowPlayingMoviesBloc>(context)
        .add(FetchNowPlayingMovies(noOfPage: 1));
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
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
                        return
                            //   PagedListView<int, MovieModel>(
                            //   pagingController: _pagingController,
                            //   builderDelegate:
                            //       PagedChildBuilderDelegate<MovieModel>(
                            //           itemBuilder: (context, item, index) {
                            //     return Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 10, vertical: 10),
                            //       child: MovieWidget(
                            //         onTap: () {},
                            //         image: item.posterPath,
                            //         title: item.title,
                            //         overview: item.overview,
                            //       ),
                            //     );
                            //   }),
                            // );
                            Pagination<MovieModel>(
                          pageBuilder: (currentSize) =>
                              pageData(currentSize, topMovies),
                          itemBuilder: (index, item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: MovieWidget(
                                onTap: () {},
                                image: item.posterPath,
                                title: item.title,
                                overview: item.overview,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("Error"));
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
