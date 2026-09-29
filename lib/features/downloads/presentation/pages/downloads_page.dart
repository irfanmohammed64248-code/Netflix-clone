import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/download_provider.dart';

class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadedMovies = ref.watch(downloadProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Downloads'),
      ),
      body: downloadedMovies.isEmpty
          ? const Center(
              child: Text(
                'No downloads yet',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: downloadedMovies.length,
              itemBuilder: (context, index) {
                final movie = downloadedMovies[index];

                return ListTile(
                  contentPadding: const EdgeInsets.only(bottom: 12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      width: 60,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    movie.releaseDate,
                    style: const TextStyle(color: Colors.white60),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(downloadProvider.notifier).removeMovie(movie.id);
                    },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
