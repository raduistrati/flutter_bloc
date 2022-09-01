
import 'package:bloc_architecture_test/src/resources/movie_api_provider.dart';
import 'package:bloc_architecture_test/src/models/item_model.dart';
import 'package:bloc_architecture_test/src/models/trailer_model.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() =>
      moviesApiProvider.fetchMovieList();
  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}