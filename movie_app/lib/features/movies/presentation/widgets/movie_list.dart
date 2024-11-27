import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/core/app_constants.dart';
import 'package:movie_app/features/movies/data/remote/movie_service.dart';
import 'package:movie_app/features/movies/data/repository/movie_repository.dart';
import 'package:movie_app/features/movies/domain/movie.dart';
import 'package:movie_app/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:movie_app/features/movies/presentation/widgets/movie_list_item.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.path});
  final String path;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: AppConstants.pageInitial);

  Future<void> _fetchPage(int page) async {
    try {
      final List<Movie> newMovies =
          await MovieRepository(movieService: MovieService())
              .getMovies(widget.path, page);
      final bool isLastPage = newMovies.length < AppConstants.pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newMovies);
      } else {
        _pagingController.appendPage(newMovies, page + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 300,
        child: PagedListView<int, Movie>(
          pagingController: _pagingController,
          scrollDirection: Axis.horizontal,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, movie, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(id: movie.id),
                      ));
                },
                child: MovieListItem(movie: movie)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
