import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/domain/movie.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              height: 280,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              left: 10,
              top: 10,
              child: Stack(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.yellow.shade800,
                    size: 40,
                  ),
                  Positioned.fill(
                      child: Center(
                    child: Text(movie.voteAverage.toStringAsFixed(1)),
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
