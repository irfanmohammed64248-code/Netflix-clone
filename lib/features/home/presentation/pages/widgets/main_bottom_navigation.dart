import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const MainBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Color(0xFF151515)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: "Home",
            index: 0,
          ),
          _buildNavigationItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: "Search",
            index: 1,
          ),
          _buildNavigationItem(
            icon: Icons.download_outlined,
            activeIcon: Icons.download,
            label: "Downloads",
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onItemSelected(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? Colors.white : Colors.grey,
            size: 25,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
