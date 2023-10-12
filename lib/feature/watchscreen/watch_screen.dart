import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/detailscreen/movie_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  bool searchClicked=false;
  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
   var prov=Provider.of<WatchScreenProvider>(context,listen: false);
   prov.init();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Widget appBar = !searchClicked?Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color(0xffE5E9EC),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        )
      ]),
      height: 64,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Watch",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Color(0xff202C43))),
          ),
          IconButton(
              padding: EdgeInsets.only(right: 4),
              iconSize: 18,
              onPressed: () {

                searchClicked=!searchClicked;
                _isSearching=!_isSearching;
                setState(() {

                });
              },
              icon: Image.asset(
                "assets/icons/Search.png",
                color: Color(0xff202C43),
              )),
        ],
      ),
    ):
    TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'TV shows, movies and more',
        hintStyle: TextStyle(

        ),
        contentPadding: EdgeInsets.all(12),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        prefixIcon: Icon(Icons.search),
        suffixIcon: _isSearching
            ? IconButton(
          icon: Icon(Icons.clear,color: Colors.black),
          onPressed: () {
            setState(() {
              _controller.clear();
              _isSearching = false;
              searchClicked=!searchClicked;
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

    return Consumer<WatchScreenProvider>(
        builder: (context, watchScreenProvider, child) {
      return SafeArea(
          child: Column(
        children: [
          appBar,
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:watchScreenProvider.upcomingMovies.isNotEmpty?ListView.builder(
                itemCount: watchScreenProvider.upcomingMovies.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Movie data = watchScreenProvider.upcomingMovies[index];
                  return GestureDetector(
                    onTap: () async {
                      var prov=Provider.of<MovieDetailProvider>(context,listen: false);
                      await prov.init(data.id.toString());
                      await Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => MovieDetailScreen(
                                selectedMovie: data,
                              )));
                    },
                    child: MovieCard(
                        name: data.title, imageUrl: data.backdropPath),
                  );
                },
              ): Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return const MovieCard(
                        name:"Movie", imageUrl:"https://image.tmdb.org/t/p/w500/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg");
                  },
                ),
              )
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ));
    });
  }
}
