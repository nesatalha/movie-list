import 'package:fenix/models/movie_model.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final MovieModel movie;
  const AboutScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(child: const Icon(Icons.arrow_back, color: Colors.black12, size: 30), onTap: () {
          Navigator.pop(context);
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: movie.id,
              child: Image.network(
                "https://image.tmdb.org/t/p/w220_and_h330_face/${movie.posterPath}",
                width: double.infinity,
                fit: BoxFit.cover,
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
                    return const SafeArea(bottom: false,child: SizedBox(width: double.infinity,child: Text("Image not found", textAlign: TextAlign.center,)));
                  } else {
                    return SafeArea(child: Container());
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    Text(
                      movie.originalTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
