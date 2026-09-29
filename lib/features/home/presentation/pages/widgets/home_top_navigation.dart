import 'package:flutter/material.dart';

class HomeTopNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const HomeTopNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab(title: "Home", index: 0),
        _buildTab(title: "Tv Shows", index: 1),
        _buildTab(title: "Movies", index: 2),
      ],
    );
  }

  Widget _buildTab({required String title, required int index}) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onTabSelected(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 6),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 3,
            width: isSelected ? 25 : 0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
