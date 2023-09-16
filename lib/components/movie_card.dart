import 'package:fenix/models/movie_model.dart';
import 'package:fenix/views/about_view.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  MovieModel movie;
  MovieCard({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (ctx, a1, a2) => AboutScreen(movie: movie,)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26, width: 1)
        ),
        //width: 300,
        //height: 500,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Hero(
                tag: movie.id,
                child: Image.network(
                  "https://image.tmdb.org/t/p/w220_and_h330_face/${movie.posterPath}",
                  //height: 150,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object object, StackTrace? error) {
                    if(error != null) {
                      return SafeArea(bottom: false,child: SizedBox(width: double.infinity,child: Text("Image not found", textAlign: TextAlign.center,)));
                    } else {
                      return SafeArea(child: Container());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  movie.originalTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 5,),
              Text(movie.voteAverage.toStringAsFixed(1),style: TextStyle(color: Colors.black87),),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
