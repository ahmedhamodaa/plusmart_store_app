import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/views/home_view.dart';
import 'package:store_app/views/search_view.dart';
import 'package:store_app/views/cart_view.dart';
import 'package:store_app/views/favorites_view.dart';
import 'package:store_app/views/profile_view.dart';

class NavigationContainer extends StatefulWidget {
  final int initialIndex;

  const NavigationContainer({Key? key, this.initialIndex = 0})
    : super(key: key);

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  late int _currentIndex;

  // Define the pages here
  final List<Widget> _pages = [
    const HomeView(),
    const SearchView(),
    const CartView(),
    const FavoritesView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: kColor0,
      indicatorColor: Colors.transparent,
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: _buildDestinations(),
    );
  }

  List<NavigationDestination> _buildDestinations() {
    // Define navigation items with their respective icons and labels
    final List<Map<String, String>> items = [
      {'icon': 'home', 'label': 'Home'},
      {'icon': 'search', 'label': 'Search'},
      {'icon': 'cart', 'label': 'Cart'},
      {'icon': 'favorite', 'label': 'Favorite'},
      {'icon': 'user', 'label': 'Profile'},
    ];

    // Create destinations from the items list
    return items.map((item) {
      return NavigationDestination(
        icon: _buildIcon(item['icon']!, false),
        label: item['label']!,
        selectedIcon: _buildIcon(item['icon']!, true),
      );
    }).toList();
  }

  Widget _buildIcon(String iconName, bool isSelected) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      color: isSelected ? kColor900 : kColor400,
    );
  }
}

// Usage example in main.dart or wherever you define your routes
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      theme: ThemeData(
        // Your theme data
      ),
      home: const NavigationContainer(),
    );
  }
}
