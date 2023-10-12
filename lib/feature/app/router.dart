import 'package:flutter/material.dart';
import 'package:movie_app/feature/app/router_constants.dart';

import '../homescreen/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {


  switch(settings.name){
    case RouterConstants.MainRoute:
      return MaterialPageRoute(
          settings: settings, builder: (context) =>HomeScreen());

    default:
      return MaterialPageRoute(
          settings: settings, builder: (context) => HomeScreen());
  }


}
