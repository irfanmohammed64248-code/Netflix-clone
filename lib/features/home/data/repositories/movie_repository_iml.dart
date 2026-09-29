import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/home/data/services/movie_api_service.dart';
import 'package:api_netflix/features/home/domain/repositories/movie_reposittory.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService movieApiService;

  MovieRepositoryImpl(this.movieApiService);

  @override
  Future<List<MovieModel>> getTrendingMovies() {
    return movieApiService.getTrendingMovies();
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() {
    return movieApiService.getNowPlayingMovies();
  }

  @override
  Future<List<MovieModel>> getPopularMovies() {
    return movieApiService.getPopularMovies();
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) {
    return movieApiService.searchMovies(query);
  }
}
