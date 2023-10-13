import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/apiendpoints.dart';



class MovieCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double bottomCardPadding;
  double textWidth;

   MovieCard({Key? key, required this.name, required this.imageUrl,required this.bottomCardPadding,this.textWidth=1.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.only(bottom: bottomCardPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
                filterQuality: FilterQuality.medium,
                fit: BoxFit.cover,
                height:MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                child: Container(
                  width: MediaQuery.of(context).size.width/textWidth,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis

                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
