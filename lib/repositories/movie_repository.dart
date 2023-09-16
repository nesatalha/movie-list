import 'dart:convert';
import 'dart:developer';

import 'package:fenix/models/movie_model.dart';
import 'package:fenix/models/movie_response_model.dart';
import 'package:http/http.dart' as http;

class MoviesRepository {
  String apiKey = "ae304e3f4d3830d95075ae6914b55ddf";

  Future<MovieResponseModel> getMovies(String query, int page) async {
    try{
      var res = await http.get(
        Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&page=$page")
      );
      log("request => ${res.request!.url}");
      MovieResponseModel response = MovieResponseModel.fromJson(jsonDecode(res.body));
      log("res page => ${response.page}");
      log("res total pages => ${response.totalPages}");
      log("res total results => ${response.totalResults}");
      log("res result => ${response.results}");
      return response;
    } catch (e) {
      log("error fetching data \n${e.toString()}");
      return MovieResponseModel(page: -1, results: [], totalPages: 0, totalResults: 0);
    }
  }
}