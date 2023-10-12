import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail.dart';
import '../../common/constants/apiendpoints.dart';
import '../../models/movie_image.dart';
import '../../models/movie_video.dart';
import '../../service/api_services.dart';

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}


class MovieDetailProvider extends ChangeNotifier{
   MovieImage  selectedImage=MovieImage();
   MovieDetail  selectedMovieDetails=MovieDetail();
   MovieVideo  selectedMovieVideo=MovieVideo();


   String date='' ;
   String year='' ;
  late int month;


  Future<void> init(String id) async{
    await fetchImages(id);
    await fetchMovieDetails(id);
    await fetchVideo(id);
  }

   Color getRandomColor() {
     final Random random = Random();
     // return Color(0xFF000000 + random.nextInt(0x00FFFFFF));
     return Color((random.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
   }


  void setDate(String serverDate){
    date=serverDate.substring(8,serverDate.length);
    year=serverDate.substring(0,4);
    month=int.parse(serverDate.substring(6,7));

  }

   String getMonthFromInt(int month) {
     switch (month) {
       case 1:
         return Month.January.toString().split('.').last;
       case 2:
         return Month.February.toString().split('.').last;
       case 3:
         return Month.March.toString().split('.').last;
       case 4:
         return Month.April.toString().split('.').last;
       case 5:
         return Month.May.toString().split('.').last;
       case 6:
         return Month.June.toString().split('.').last;
       case 7:
         return Month.July.toString().split('.').last;
       case 8:
         return Month.August.toString().split('.').last;
       case 9:
         return Month.September.toString().split('.').last;
       case 10:
         return Month.October.toString().split('.').last;
       case 11:
         return Month.November.toString().split('.').last;
       case 12:
         return Month.December.toString().split('.').last;
       default:
         return 'Invalid Month';
     }
   }



  Future<void> fetchImages(String id) async{
    try {
      final response= await ApiService.get("/$id${ApiEndPoint.movieImageUrl}");
      if(response!=null){
        Map<String, dynamic> data = response.data;
        selectedImage=MovieImage.fromJson(data);
        notifyListeners();
      }else{
        print("Something went wrong");
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
  

  Future<void> fetchMovieDetails(String id) async{
    try {
      final response= await ApiService.get("/$id");
      if(response!=null){
        Map<String, dynamic> data = response.data;
        selectedMovieDetails=MovieDetail.fromJson(data);
        notifyListeners();
      }else{
        print("Something went wrong");
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

   Future<void> fetchVideo(String id) async{
     try {
       final response= await ApiService.get("/$id${ApiEndPoint.videoUrl}");
       if(response!=null){
         Map<String, dynamic> data = response.data;
         selectedMovieVideo=MovieVideo.fromJson(data);
         notifyListeners();
       }else{
         print("Something went wrong");
       }
     } catch (e) {
       throw Exception('Failed to load movies: $e');
     }
   }

}