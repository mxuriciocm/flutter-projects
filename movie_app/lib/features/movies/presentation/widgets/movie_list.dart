import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/data/remote/movie_service.dart';
import 'package:movie_app/features/movies/data/repository/movie_repository.dart';
import 'package:movie_app/features/movies/domain/movie.dart';
import 'package:movie_app/features/movies/presentation/widgets/movie_list_item.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.path});
  final String path;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> _movies = [];

  Future<void> _loadData() async {
    List<Movie> movies = await MovieRepository(movieService: MovieService())
        .getMovies(widget.path, 1);

    setState(() {
      _movies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movies.length,
        itemBuilder: (context, index) => MovieListItem(movie: _movies[index]));
  }
}
