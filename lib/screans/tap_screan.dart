import 'package:aqarak/navbar/profile.dart';
import 'package:aqarak/navbar/saved.dart';
import 'package:aqarak/navbar/search.dart';
import 'package:aqarak/screans/homepage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class TapScrean extends StatefulWidget {
  const TapScrean({super.key});

  @override
  State<TapScrean> createState() => _TapScreanState();
}

class _TapScreanState extends State<TapScrean> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  Color color = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
  // ignore: deprecated_member_use
  backgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9), // Softer background
  activeColor: color, // Your accent color
  inactiveColor: Colors.white70, // Better contrast with grey background
  currentIndex: currentPage, // Sync with controller
  iconSize: 28, // Optimal icon size
  height: 60, // Better touch target
  border: Border(top: BorderSide(color: Colors.grey.shade300)), // Add top border
  onTap: (index) {
    _pageController.jumpToPage(index);
    setState(() => currentPage = index);
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'الرئيسية ',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: 'البحث',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_outline),
      activeIcon: Icon(Icons.bookmark),
      label: 'المحفظات',
    ),
    
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'الملف الشخصي ',
    ),
  ],
),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {},
          children: [
            Homepage(),
            Search(propertyKey: '',  propertyImage: '', propertyValue: '', ),
            FavoritesScreen(),
            Profile(),
          ]),
    );
  }
}
