import 'package:flutter/material.dart';
import 'home.dart';
import 'business.dart';
import 'entertainment.dart';
import 'sports.dart';
import 'tecnology.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedindex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Homepage(),
          Businesswidget(),
          Entertainmentwidget(),
          Tecnologypage(),
          Sportswidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),

            label: 'Entertainment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Technology',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        onTap: onTapped,
      ),
    );
  }
}
