class MovieModel {
  int id;
  bool adult;
  String backdropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String title;
  double popularity;
  double voteAverage;

  MovieModel({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.popularity,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String,dynamic> json) {
    return MovieModel(
      id: json["id"],
      adult: json["adult"],
      backdropPath: json["backdrop_path"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      title: json["title"] ?? "",
      popularity: json["popularity"],
      voteAverage: json["vote_average"],
    );
  }
}
