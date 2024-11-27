import 'dart:convert';
import 'dart:io';

import 'package:movie_app/core/app_constants.dart';
import 'package:movie_app/features/movies/data/remote/movie_dto.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<List<MovieDto>> getMovies(String path, int page) async {
    String url =
        '${AppConstants.baseUrl}${AppConstants.moviePath}$path${AppConstants.apiKeyQuery}${AppConstants.pageQuery}$page';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatus.ok) {
        dynamic jsonResponse = jsonDecode(response.body);
        List maps = jsonResponse['results'];
        return maps.map((map) => MovieDto.fromJson(map)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
