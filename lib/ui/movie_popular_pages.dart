import 'package:dio_sample_app/bloc/movies_bloc.dart';
import 'package:dio_sample_app/bloc/movies_event.dart';
import 'package:dio_sample_app/bloc/movies_state.dart';
import 'package:dio_sample_app/model/popular_movie_item.dart';
import 'package:dio_sample_app/ui/chip_genre_movies.dart';
import 'package:dio_sample_app/ui/shimmer_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePopularPages extends StatefulWidget {
  @override
  _MoviePopularPagesState createState() => _MoviePopularPagesState();
}

class _MoviePopularPagesState extends State<MoviePopularPages> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(LoadPopularMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Popular'),
      ),
      body: BlocBuilder<MovieBloc, MoviesState>(
          builder: (context, state){
            if(state is MoviesHasData){
              return BuildList(listMoviePopular: state.movieList);
            }else if(state is MoviesLoading){
              return ShimmerMovies();
            }else if(state is MoviesError){
              return Center(child: Text(state.errorMessage));
            }else if(state is MoviesNoInternetConnection){
              return Center(child: Text(state.message),);
            }
            else {
              return Center(child: Text(''));
            }
          }
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

