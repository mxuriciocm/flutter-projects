import 'package:movie_app/features/movies/domain/movie_detail.dart';

class MovieDetailDto {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final double voteAverage;
  final List<GenreDto> genres;

  MovieDetailDto({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailDto(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path'] ?? ''}',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      genres: (json['genres'] as List)
              .map<GenreDto>((genreDto) => GenreDto.fromJson(genreDto))
              .toList(),
    );
  }

  MovieDetail toMovieDetail() {
    return MovieDetail(
      id: id,
      title: title,
      overview: overview,
      releaseDate: releaseDate,
      posterPath: posterPath,
      voteAverage: voteAverage,
      genres: genres.map((genreDto) => genreDto.name).toList(),
    );
  }
}

class GenreDto {
  final int id;
  final String name;

  GenreDto({
    required this.id,
    required this.name,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) {
    return GenreDto(
      id: json['id'],
      name: json['name'],
    );
  }
}
