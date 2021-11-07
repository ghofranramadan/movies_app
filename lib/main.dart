import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_connect.dart';
import 'package:movies_app/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/utils/theme.dart';

import 'bloc/now_playing_bloc/now_playing_movies_bloc.dart';
import 'bloc/top_movies_bloc/top_movies_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiProvider.int();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopMoviesBloc>(
          create: (context) => TopMoviesBloc(),
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => PopularMoviesBloc(),
        ),
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => NowPlayingMoviesBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App Task',
        theme: MoviesAppTheme().lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
