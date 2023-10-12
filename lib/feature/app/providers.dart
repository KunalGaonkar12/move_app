import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../detailscreen/movie_detail_provider.dart';
import '../watchscreen/watch_screen_provider.dart';

class Providers{
  static List<SingleChildWidget> getAProviders(){
    List<SingleChildWidget> providers = [
      ChangeNotifierProvider(create: (context)=>WatchScreenProvider()),
      ChangeNotifierProvider(create: (context)=>MovieDetailProvider()),
    ];
    return providers;

  }

}