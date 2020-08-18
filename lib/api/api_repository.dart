

import 'package:dio_sample_app/api/api_provider.dart';
import 'package:dio_sample_app/model/popular_movie_item.dart';

class ApiRepository {

  ApiProvider _apiProvider = ApiProvider() ;

  Future<List<PopularMovieItem>> get getMoviePopular => _apiProvider.getMoviePopular();

}