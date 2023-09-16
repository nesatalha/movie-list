import 'package:fenix/models/movie_model.dart';

class MovieResponseModel {
  int page;
  List<MovieModel> results;
  int totalPages;
  int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) => MovieResponseModel(
    page: json["page"],
    results: (json["results"] as List).map((e) => MovieModel.fromJson(e)).toList(),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}