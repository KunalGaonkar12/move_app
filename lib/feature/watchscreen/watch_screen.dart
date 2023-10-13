import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/feature/detailscreen/movie_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common/constants/fonts.dart';
import '../../customwidgets/movie_card.dart';
import '../../models/movie.dart';
import '../detailscreen/movie_detail_screen.dart';
import 'watch_screen_provider.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  bool searchClicked = false;
  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    var prov = Provider.of<WatchScreenProvider>(context, listen: false);
    prov.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchScreenProvider>(
        builder: (context, watchScreenProvider, child) {
      return OrientationBuilder(builder: (context, orientation) {
        return SafeArea(
            child: Column(
          children: [
            _customAppBar(),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: orientation == Orientation.portrait
                      ? _portraitView(context, watchScreenProvider)
                      : _landScapeView(context,watchScreenProvider)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
      });
    });
  }

  Widget _portraitView(
      BuildContext context, WatchScreenProvider watchScreenProvider) {
    return watchScreenProvider.upcomingMovies.isNotEmpty
        ? ListView.builder(
            itemCount: watchScreenProvider.upcomingMovies.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Movie data = watchScreenProvider.upcomingMovies[index];
              return GestureDetector(
                onTap: () async {
                  var prov =
                      Provider.of<MovieDetailProvider>(context, listen: false);
                  await prov.init(data.id.toString());
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => MovieDetailScreen(
                                selectedMovie: data,
                              )));
                },
                child: MovieCard(name: data.title, imageUrl: data.backdropPath,bottomCardPadding: 20),
              );
            },
          )
        : Skeletonizer(
            enabled: true,
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return  MovieCard(
                    name: "Movie",
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",bottomCardPadding: 20,);
              },
            ),
          );
  }

  Widget _landScapeView(BuildContext context,WatchScreenProvider watchScreenProvider){
    return watchScreenProvider.upcomingMovies.isNotEmpty
        ?GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1.7, // Number of columns
        ),
        scrollDirection: Axis.vertical,
        itemCount: watchScreenProvider.upcomingMovies.length,
        itemBuilder: (context, index) {
          Movie data =
          watchScreenProvider.upcomingMovies[index];
          return GestureDetector(
            onTap: () async {
              var prov = Provider.of<MovieDetailProvider>(
                  context,
                  listen: false);
              await prov.init(data.id.toString());
              await Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => MovieDetailScreen(
                        selectedMovie: data,
                      )));
            },
            child: MovieCard(
                name: data.title,
                imageUrl: data.backdropPath,bottomCardPadding: 14,textWidth: 3),
          );
        }):GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.7, // Number of columns
        ),
        scrollDirection: Axis.vertical,
        itemCount: watchScreenProvider.upcomingMovies.length,
        itemBuilder: (context, index) {
          return MovieCard(
              name: "Dummy",
              imageUrl: "https://image.tmdb.org/t/p/w500/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",bottomCardPadding: 10,);
        });
  }

  Widget _customAppBar() {
    return !searchClicked
        ? Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0xffE5E9EC),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              )
            ]),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 24, bottom: 24),
                  child: Text("Watch",
                      style: FontHelper.mediumPoppins(
                          color: Color(0xff202C43), fontSize: 16)),
                ),
                IconButton(
                    padding: EdgeInsets.only(right: 10),
                    iconSize: 18,
                    onPressed: () {
                      searchClicked = !searchClicked;
                      _isSearching = !_isSearching;
                      setState(() {});
                    },
                    icon: Image.asset(
                      "assets/icons/Search.png",
                      color: Color(0xff202C43),
                    )),
              ],
            ),
          )
        : TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'TV shows, movies and more',
              contentPadding: EdgeInsets.all(12),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: _isSearching
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                          _isSearching = false;
                          searchClicked = !searchClicked;
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _isSearching = value.isNotEmpty;
              });
            },
          );
  }
}
