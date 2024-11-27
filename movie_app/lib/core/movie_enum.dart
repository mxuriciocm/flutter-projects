import 'package:movie_app/core/app_constants.dart';

enum MovieEnum {
  popular(title: 'Popular', path: AppConstants.popularPath),
  topRated(title: 'Top Rated', path: AppConstants.topRatedPath),
  upcoming(title: 'Upcoming', path: AppConstants.upcomingPath),
  nowPlaying(title: 'Now Playing', path: AppConstants.nowPlayingPath);

  final String title;
  final String path;

  const MovieEnum({required this.title, required this.path});
}
