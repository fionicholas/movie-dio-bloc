import 'package:dio_sample_app/model/popular_movie_item.dart';

class PopularMovieModel {

  int page;
  int total_results;
  int total_pages;
  List<PopularMovieItem> results;

	PopularMovieModel.fromJsonMap(Map<String, dynamic> map): 
		page = map["page"],
		total_results = map["total_results"],
		total_pages = map["total_pages"],
		results = List<PopularMovieItem>.from(map["results"].map((it) => PopularMovieItem.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['page'] = page;
		data['total_results'] = total_results;
		data['total_pages'] = total_pages;
		data['results'] = results != null ? 
			this.results.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
