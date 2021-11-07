import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/model/movie_details_model.dart';
import 'package:movies_app/utils/var.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsSuccessState) {
            MovieDetailsModel movieDetails = state.movieDetails;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: Constant.baseUrlOfImage +
                              movieDetails.backdropPath,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.fill,
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) => Center(
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.16),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              child: CachedNetworkImage(
                                imageUrl: Constant.baseUrlOfImage +
                                    movieDetails.posterPath,
                                height: 190,
                                width: MediaQuery.of(context).size.width * 0.45,
                                fit: BoxFit.fill,
                                placeholder: (_, __) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (_, __, ___) => Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 16, bottom: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movieDetails.originalTitle,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        movieDetails.releaseDate,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        movieDetails.voteCount.toString() +
                                            ' Votes',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 15,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  Text(
                                                    movieDetails
                                                        .genres[index].name,
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4,
                                                  ),
                                              separatorBuilder:
                                                  (context, index) => Text(
                                                        ' , ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4,
                                                      ),
                                              itemCount:
                                                  movieDetails.genres.length),
                                        ),
                                        movieDetails.spokenLanguages.isNotEmpty
                                            ? Text(
                                                movieDetails
                                                    .spokenLanguages[0].name,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(fontSize: 16),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Movie Description',
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    movieDetails.overview,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
