

import 'package:dio/dio.dart';
import 'package:dio_sample_app/api/api_provider.dart';
import 'package:dio_sample_app/bloc/movies_event.dart';
import 'package:dio_sample_app/bloc/movies_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  final ApiProvider repository;

  MovieBloc({@required this.repository}) : super(InitialMoviesState());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if(event is LoadPopularMovie){
      yield* _mapLoadPopularMovieToState();
    }
  }

  Stream<MoviesState> _mapLoadPopularMovieToState() async* {
    try{
      yield MoviesLoading();
      var movies = await repository.getMoviePopular();
      if(movies.isEmpty){
        yield MoviesNoData("Movies Not Found");
      }else {
        yield MoviesHasData(movies);
      }
    } on DioError catch (e) {
      if(e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviesNoInternetConnection("No Internet Connection");
      }else if(e.type == DioErrorType.DEFAULT) {
        yield MoviesNoInternetConnection("No Internet Connection");
      }else {
        yield MoviesError(e.toString());
      }
    }
  }

}