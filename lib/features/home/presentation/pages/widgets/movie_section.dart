import 'package:flutter/material.dart';

import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_card.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_shimmer_list.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel>? movies;
  final bool isLoading;
  final bool isLarge;

  const MovieSection({
    super.key,
    required this.title,
    this.movies,
    this.isLoading = false,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 15),

        if (isLoading)
          const MovieShimmerList()
        else
          SizedBox(
            height: isLarge ? 320 : 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: movies?.length ?? 0,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemBuilder: (context, index) {
                return MovieCard(movie: movies![index], isLarge: isLarge);
              },
            ),
          ),

        const SizedBox(height: 30),
      ],
    );
  }
}
