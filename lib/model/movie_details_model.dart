class MovieDetailsModel {
  late bool adult;
  late String backdropPath;
  late int budget;
  late List<Genres> genres = <Genres>[];
  late List<SpokenLanguages> spokenLanguages = <SpokenLanguages>[];
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late List<ProductionCompanies> productionCompanies = <ProductionCompanies>[];
  late String releaseDate;
  late double voteAverage;
  late int voteCount;
  MovieDetailsModel({
    required this.adult,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.budget,
    required this.productionCompanies,
  });
  MovieDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
    budget = json["budget"];
    json['genres'].forEach((element) => genres.add(Genres.fromJson(element)));
    json['spoken_languages'].forEach(
        (element) => spokenLanguages.add(SpokenLanguages.fromJson(element)));
    json['production_companies'].forEach((element) =>
        productionCompanies.add(ProductionCompanies.fromJson(element)));
  }
}

class ProductionCompanies {
  late int id;
  late String logoPath;
  late String name;
  late String originCountry;
  ProductionCompanies({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });
  ProductionCompanies.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json["id"];
    logoPath = json["logo_path"];
    name = json["name"];
    originCountry = json["origin_country"];
  }
}

class Genres {
  late int id;
  late String name;
  Genres({
    required this.id,
    required this.name,
  });
  Genres.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json["id"];

    name = json["name"];
  }
}

class SpokenLanguages {
  late String name;
  SpokenLanguages({
    required this.name,
  });
  SpokenLanguages.fromJson(
    Map<String, dynamic> json,
  ) {
    name = json["name"];
  }
}
