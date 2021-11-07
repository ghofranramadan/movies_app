class MovieListModel {
  late int page;
  late int totalResults;
  late int totalPages;
  late List<MovieModel> movies = <MovieModel>[];

  MovieListModel({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.movies,
  });

  MovieListModel.fromJson(
    Map<String, dynamic> json,
  ) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    json['results']
        .forEach((element) => movies.add(MovieModel.fromJson(element)));
  }
}

class MovieModel {
  late bool adult;
  late String backdropPath;
  late List<int> genreIds = <int>[];
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  // late double voteAverage;
  late int voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    // required this.voteAverage,
    required this.voteCount,
  });

  MovieModel.fromJson(
    Map<String, dynamic> json,
  ) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    json['genre_ids'].forEach((element) => genreIds.add(element));
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    // voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }
}
