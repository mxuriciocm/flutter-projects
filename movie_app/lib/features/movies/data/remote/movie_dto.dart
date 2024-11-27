import 'package:movie_app/core/app_constants.dart';
import 'package:movie_app/features/movies/domain/movie.dart';

class MovieDto {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final double voteAverage;
  final List<int> genreIds;

  MovieDto({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }

  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      releaseDate: releaseDate,
      posterPath: AppConstants.imageBaseUrl + posterPath,
      voteAverage: voteAverage,
    );
  }
}