import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isLarge;
  final double? cardWidth;

  const MovieCard({
    super.key,
    required this.movie,
    this.isLarge = false,
    this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width;

        if (cardWidth == double.infinity) {
          width = constraints.maxWidth;
        } else {
          width = cardWidth ?? (isLarge ? 170 : 120);
        }

        final double imageHeight = isLarge ? 250 : width * 1.5;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsPage(movie: movie),
              ),
            );
          },
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: width,
                        height: imageHeight,
                        color: Colors.grey.shade900,
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
