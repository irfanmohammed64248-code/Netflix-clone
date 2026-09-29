import 'package:api_netflix/features/home/presentation/pages/widgets/movie_card_shimmer.dart';
import 'package:flutter/material.dart';

class MovieShimmerList extends StatelessWidget {
  const MovieShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return MovieCardShimmer();
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 12);
        },
        itemCount: 6,
      ),
    );
  }
}
