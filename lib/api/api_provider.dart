import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_sample_app/model/popular_movie_item.dart';

class ApiProvider {
  Dio dio = Dio();

  Future<List<PopularMovieItem>> getMoviePopular() async {
    try {
      Response response = await Dio().get(
          "https://api.themoviedb.org/3/movie/popular",
          queryParameters: {"api_key": "1b5c4f231f6dfe2b546cc12df8af1949"});
      if(response.statusCode == 200){
        final List responseData = jsonDecode(jsonEncode(response.data['results']));
        List<PopularMovieItem> popularMovieList = responseData.map((e) => PopularMovieItem.fromJsonMap(e)).toList();
        return popularMovieList;
      }else {
        print("Error when fetching data");
      }

    } catch (e) {
      print(e);
    }
  }
}
