import 'package:movie_app/features/movies/data/remote/movie_detail_dto.dart';
import 'package:movie_app/features/movies/data/remote/movie_dto.dart';
import 'package:movie_app/features/movies/data/remote/movie_service.dart';
import 'package:movie_app/features/movies/domain/movie.dart';
import 'package:movie_app/features/movies/domain/movie_detail.dart';

class MovieRepository {
  final MovieService movieService;
  MovieRepository({required this.movieService});

  Future<List<Movie>> getMovies(String path, int page) async{
    List<MovieDto> moviesDto = await movieService.getMovies(path, page);
    return moviesDto.map((moviesDto) => moviesDto.toMovie()).toList();
  }

  Future<MovieDetail?> getMovieById(int id) async{
    MovieDetailDto? movieDetailDto = await movieService.getMovieById(id);
    return movieDetailDto?.toMovieDetail();
  }
}