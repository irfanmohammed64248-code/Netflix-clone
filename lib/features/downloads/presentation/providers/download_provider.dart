import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api_netflix/features/home/data/models/movie_model.dart';

class DownloadNotifier extends Notifier<List<MovieModel>> {
  @override
  List<MovieModel> build() {
    return [];
  }

  void addMovie(MovieModel movie) {
    final alreadyDownloaded = state.any((item) => item.id == movie.id);

    if (alreadyDownloaded) {
      return;
    }

    state = [...state, movie];
  }

  void removeMovie(int movieId) {
    state = state.where((movie) => movie.id != movieId).toList();
  }
}

final downloadProvider = NotifierProvider<DownloadNotifier, List<MovieModel>>(
  () => DownloadNotifier(),
);
