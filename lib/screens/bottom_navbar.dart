import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/screens/crud/crudscreen.dart';
import 'package:my_test_app/screens/profile/profile.dart';
import 'package:my_test_app/screens/tasks/taskscreen.dart';
import 'package:provider/provider.dart';

import '../providers/userProvider.dart';
import 'home/homescreen.dart';

class BottomNavigationbar extends StatefulWidget {
  const BottomNavigationbar({Key? key}) : super(key: key);
  static const route = 'BottomNavigationbar';
  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    UserCrudScreen(),
    TaskUploadScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser();
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: bottomBarPages,
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController: _controller,
          color: Colors.white,
          showLabel: false,
          notchColor: Colors.black87,

          /// restart app if you change removeMargins
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 300,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home_filled,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              itemLabel: 'Page 1',
            ),

            ///svg example
            BottomBarItem(
              inActiveItem: Icon(
                Icons.analytics,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.analytics,
                color: Colors.white,
              ),
              itemLabel: 'Page 3',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.task,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.task,
                color: Colors.white,
              ),
              itemLabel: 'Page 4',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.person,
                color: Colors.white,
              ),
              itemLabel: 'Page 5',
            ),
          ],
          onTap: (index) {
            /// perform action on tab change and to update pages you can update pages without pages

            _pageController.jumpToPage(index);
          },
        ));
  }
}
