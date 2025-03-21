import 'package:bgmi/Screens/settings_screen.dart';
import 'package:bgmi/Screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:bgmi/screens/side_menu.dart';
import 'package:bgmi/screens/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      Center(
        child: Text(
          "Home Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        child: Text(
          "Schedule Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      WalletScreen(),
      Center(
        child: Text(
          "Categories Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      SettingsScreen(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BGMI Tournament"),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blue,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),
      drawer: SideMenu(),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onItemTapped(2),
        backgroundColor: Colors.purple,
        shape: CircleBorder(),
        child: Icon(
          Icons.account_balance_wallet_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
