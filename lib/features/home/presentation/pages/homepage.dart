import 'package:api_netflix/features/downloads/presentation/pages/downloads_page.dart';

import 'package:api_netflix/features/home/presentation/pages/widgets/home_top_navigation.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/main_bottom_navigation.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_section.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_shimmer_list.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/trending_movie_carousel.dart';

import 'package:api_netflix/features/home/presentation/providers/movie_provider.dart';
import 'package:api_netflix/features/home/presentation/providers/navigation_provider.dart';

import 'package:api_netflix/features/search/presentation/pages/search_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTopTab = ref.watch(topNavigationProvider);

    final selectedBottomIndex = ref.watch(bottomNavigationProvider);

    final trendingMovies = ref.watch(trendingMoviesProvider);

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final popularMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      body: selectedBottomIndex == 0
          ? SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "NETFLIX",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  HomeTopNavigation(
                    selectedIndex: selectedTopTab,
                    onTabSelected: (index) {
                      ref.read(topNavigationProvider.notifier).changeTab(index);
                    },
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),

                        // Trending Now
                        if (trendingMovies.isLoading)
                          const MovieShimmerList()
                        else if (trendingMovies.hasValue)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Trending Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TrendingMovieCarousel(
                                movies: trendingMovies.value!,
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),

                        // Now Playing
                        MovieSection(
                          title: 'Now Playing',
                          isLoading: nowPlayingMovies.isLoading,
                          movies: nowPlayingMovies.value,
                        ),

                        // Popular Movies
                        MovieSection(
                          title: 'Popular Movies',
                          isLoading: popularMovies.isLoading,
                          movies: popularMovies.value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          // Search
          : selectedBottomIndex == 1
          ? const SearchPage()
          // Downloads
          : const DownloadsPage(),

      bottomNavigationBar: MainBottomNavigation(
        selectedIndex: selectedBottomIndex,
        onItemSelected: (index) {
          ref.read(bottomNavigationProvider.notifier).changeTab(index);
        },
      ),
    );
  }
}
