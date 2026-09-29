import 'package:api_netflix/features/home/data/repositories/movie_repository_iml.dart';
import 'package:api_netflix/features/home/domain/repositories/movie_reposittory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:api_netflix/features/home/data/services/movie_api_service.dart';
import 'package:api_netflix/core/network/dio_client.dart';

import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'dart:async';

// API Service Provider
final movieApiServiceProvider = Provider<MovieApiService>((ref) {
  final dioClient = DioClient();

  return MovieApiService(dioClient);
});

// Repository Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final movieApiService = ref.read(movieApiServiceProvider);

  return MovieRepositoryImpl(movieApiService);
});

// Trending Movies
final trendingMoviesProvider = FutureProvider<List<MovieModel>>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return repository.getTrendingMovies();
});

// Now Playing Movies
final nowPlayingMoviesProvider = FutureProvider<List<MovieModel>>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return repository.getNowPlayingMovies();
});

// Popular Movies
final popularMoviesProvider = FutureProvider<List<MovieModel>>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return repository.getPopularMovies();
});

final searchMoviesProvider = FutureProvider.family<List<MovieModel>, String>((
  ref,
  query,
) {
  final repository = ref.read(movieRepositoryProvider);

  return repository.searchMovies(query);
});

class SearchQueryNotifier extends Notifier<String> {
  Timer? _timer;

  @override
  String build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return '';
  }

  void updateQuery(String query) {
    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 500), () {
      state = query.trim();
    });
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);
