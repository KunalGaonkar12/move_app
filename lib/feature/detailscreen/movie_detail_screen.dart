import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/apiendpoints.dart';
import 'package:movie_app/feature/videoplayer/video_player_screen.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common/constants/palette.dart';
import '../../models/movie.dart';
import 'movie_detail_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie selectedMovie;

  const MovieDetailScreen({Key? key, required this.selectedMovie})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    var prov = Provider.of<MovieDetailProvider>(context, listen: false);
    prov.fetchImages(widget.selectedMovie.id.toString());
    prov.setDate(widget.selectedMovie.releaseDate.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailProvider>(
        builder: (context, movieDetailProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Palette.backgroundColor,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.00, 1.00),
                                end: Alignment(0, -1),
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0)
                                ],
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${ApiEndPoint.imageBaseUrl}${movieDetailProvider.selectedImage.posters![0].filePath}"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, 1.00),
                              end: Alignment(0, -1),
                              colors: [Colors.black, Colors.black.withOpacity(0)],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _customAppBar(context),
                            SizedBox(height:70),
                            CachedNetworkImage(
                              imageUrl:
                                  "${ApiEndPoint.imageBaseUrl}${movieDetailProvider.selectedImage.logos![0].filePath}",
                              fit: BoxFit.contain,
                              height: 30,
                              width: 102,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "In Theaters ${movieDetailProvider.getMonthFromInt(movieDetailProvider.month)} ${movieDetailProvider.date},${movieDetailProvider.year} ",
                              style: const  TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                print("Book Tickets");
                              },
                              child: Container(
                                width: 243,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF61C3F2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Get Tickets',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                print("Watch Trailer Clicked");
                                print("${ApiEndPoint.youtubeUrl}${movieDetailProvider.selectedMovieVideo.results![0].key}");
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => YouTubePlayerScreen(
                                    videoUrl:"${ApiEndPoint.youtubeUrl}${movieDetailProvider.selectedMovieVideo.results![0].key}")
                                ));
                              },
                              child: Container(
                                width: 243,
                                height: 50,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFF61C3F2)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow,
                                        color: Colors.white, size: 18),
                                    Text(
                                      'Watch Trailer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),SizedBox(height:10,) // Container(
                            //
                            // )
                          ],
                        ),
                      ],
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const  SizedBox(
                            height: 27,
                          ),
                          const  Text(
                            'Genres',
                            style: TextStyle(
                              color: Color(0xFF202C43),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: movieDetailProvider
                                    .selectedMovieDetails.genres!
                                    .map(
                                      (e) => Container(
                                        // width: 60,
                                        // height: 24,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: ShapeDecoration(
                                          color: movieDetailProvider
                                              .getRandomColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            child: Text(
                                              e.name ?? "",
                                              softWrap: true,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ),
                        const  SizedBox(
                            height: 39,
                          ),
                         const Text(
                            'Overview',
                            style: TextStyle(
                              color: Color(0xFF202C43),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.08,
                            ),
                          ),
                         const SizedBox(
                            height: 14,
                          ),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  movieDetailProvider
                                          .selectedMovieDetails.overview ??
                                      "",
                                  style:const TextStyle(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                         const  SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }


  Widget _customAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: 95,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
        const  Text("Watch",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
