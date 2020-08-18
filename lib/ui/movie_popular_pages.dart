import 'package:dio_sample_app/api/api_repository.dart';
import 'package:dio_sample_app/ui/chip_genre_movies.dart';
import 'package:dio_sample_app/model/popular_movie_item.dart';
import 'package:dio_sample_app/ui/shimmer_movies.dart';
import 'package:flutter/material.dart';

class MoviePopularPages extends StatefulWidget {
  @override
  _MoviePopularPagesState createState() => _MoviePopularPagesState();
}

class _MoviePopularPagesState extends State<MoviePopularPages> {
  ApiRepository _apiRepository = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Popular'),
      ),
      body: Container(
        child: FutureBuilder(
            future: _apiRepository.getMoviePopular,
            builder: (BuildContext context, AsyncSnapshot<List<PopularMovieItem>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: ShimmerMovies(),
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text("Failed get data"),
                      ),
                    );
                  } else {
                    return BuildList(listMoviePopular: snapshot.data,);
                  }
                  break;
              }
              return Center(child: Text(""));
            }),
      ),
    );
  }
}

class BuildList extends StatelessWidget {
  const BuildList({Key key, this.listMoviePopular}) : super(key: key);

  final List<PopularMovieItem> listMoviePopular;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(
          itemCount: listMoviePopular.length,
          itemBuilder: (context, index) {
            PopularMovieItem movies = listMoviePopular[index];
            return Padding(
              padding: const EdgeInsets.only(left :8.0, right : 8.0, bottom: 8.0),
              child: Card(
                elevation: 10.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network('https://image.tmdb.org/t/p/w185/${movies.poster_path}'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top : 8.0),
                            child: Text(movies.title, style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical : 8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: movies.genre_ids.take(3).map(buildGenreChip).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom : 8.0),
                            child: Text(movies.overview.substring(0, 100)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

