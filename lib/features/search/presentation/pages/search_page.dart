import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:api_netflix/features/home/presentation/pages/widgets/movie_card.dart';
import 'package:api_netflix/features/home/presentation/providers/movie_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);

    final searchResults = searchQuery.isEmpty
        ? null
        : ref.watch(searchMoviesProvider(searchQuery));

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Search'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: const TextStyle(color: Colors.white54),

                prefixIcon: const Icon(Icons.search, color: Colors.white70),

                filled: true,
                fillColor: const Color(0xFF1F1F1F),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).updateQuery(value);
              },
            ),
          ),

          Expanded(
            child: searchQuery.isEmpty
                ? const Center(
                    child: Text(
                      'Search for a movie',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  )
                : searchResults!.when(
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    },

                    error: (error, stack) {
                      return const Center(
                        child: Text(
                          'Something went wrong',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },

                    data: (movies) {
                      if (movies.isEmpty) {
                        return const Center(
                          child: Text(
                            'No movies found',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,

                              // More vertical space for
                              // poster + title + rating
                              childAspectRatio: 0.48,
                            ),

                        itemCount: movies.length,

                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: movies[index],
                            cardWidth: double.infinity,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
