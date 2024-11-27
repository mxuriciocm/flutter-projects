import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/data/remote/movie_service.dart';
import 'package:movie_app/features/movies/data/repository/movie_repository.dart';
import 'package:movie_app/features/movies/domain/movie_detail.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.id});
  final int id;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail? _movieDetail;

  Future<void> _loadData() async {
    final movieDetail = await MovieRepository(movieService: MovieService())
        .getMovieById(widget.id);
    setState(() {
      _movieDetail = movieDetail;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: (_movieDetail == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Image.network(
                    _movieDetail!.posterPath,
                    height: height * 0.60,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined,
                          color: Colors.white, size: 30),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
