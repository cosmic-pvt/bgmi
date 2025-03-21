import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.black,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: selectedIndex == 0 ? Colors.blue : Colors.white,
              ),
              onPressed: () => onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.schedule_rounded,
                color:
                    selectedIndex == 1
                        ? const Color.fromARGB(255, 183, 136, 53)
                        : Colors.white,
              ),
              onPressed: () => onItemTapped(1),
            ),
            SizedBox(width: 40), // Space for FAB
            IconButton(
              icon: Icon(
                Icons.category_rounded,
                color:
                    selectedIndex == 3
                        ? const Color.fromARGB(255, 10, 140, 99)
                        : Colors.white,
              ),
              onPressed: () => onItemTapped(3),
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color:
                    selectedIndex == 4
                        ? const Color.fromARGB(255, 165, 13, 13)
                        : Colors.white,
              ),
              onPressed: () => onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
