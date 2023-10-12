
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/apiendpoints.dart';
import 'package:movie_app/models/movie.dart';

import '../../service/api_services.dart';


class WatchScreenProvider extends ChangeNotifier{

  late TabController bottomTabController;
  List<Movie> upcomingMovies=[];

  void init() async {
    upcomingMovies=[];
    await fetchMovies();

  }


  Future<List<Movie>> fetchMovies() async {

    try {
      final response= await ApiService.get(ApiEndPoint.movieUrl);
      if(response!=null){
        Map<String, dynamic> data = response.data;
        List results = data['results'];
        upcomingMovies=movieFromJson(results);
        notifyListeners();
        // results.forEach((element) {upcomingMovies.add(Movie.fromJson(element));});
        print(upcomingMovies);
        return upcomingMovies;
      }else{
        return upcomingMovies;
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }



}