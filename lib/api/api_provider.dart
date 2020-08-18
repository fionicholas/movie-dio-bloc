import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_sample_app/model/popular_movie_item.dart';
import 'package:dio_sample_app/model/popular_movie_model.dart';

class ApiProvider {
  Dio dio = Dio();

  var baseUrl = "https://api.themoviedb.org/3/movie/popular";
  var apiKey = "1b5c4f231f6dfe2b546cc12df8af1949";

  Future<List<PopularMovieItem>> getMoviePopular() async {
    try {
      Response response = await Dio().get(
          baseUrl, queryParameters: {"api_key": apiKey});
      if(response.statusCode == 200){

        var data = jsonDecode(jsonEncode(response.data));
        List<PopularMovieItem> popularMovieList = PopularMovieModel.fromJsonMap(data).results;
        return popularMovieList;
      }else {
        print("Error when fetching data");
      }
    } catch (e) {
      print(e);
    }
  }
}
