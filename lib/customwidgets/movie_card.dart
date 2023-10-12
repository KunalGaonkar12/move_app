import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/apiendpoints.dart';



class MovieCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const MovieCard({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
                filterQuality: FilterQuality.medium,
                fit: BoxFit.cover,
                "${ApiEndPoint.imageBaseUrl}${imageUrl}"),
            Positioned.fill(
                child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 0.95])),
            )),
            Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}
