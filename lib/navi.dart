import 'package:app/add.dart';
import 'package:app/home.dart';
import 'package:app/notification.dart';
import 'package:app/piechart.dart';
import 'package:app/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({Key? key}) : super(key: key);

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _listPages = [
    const AddData(),
    Chart(),
    const Dashboard(),
    const Notify(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30, color: Colors.white),
            Icon(Icons.dashboard, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.production_quantity_limits,
                size: 30, color: Colors.white),
            Icon(Icons.rate_review_outlined, size: 30, color: Colors.white),
          ],
          color: const Color.fromARGB(255, 8, 6, 90).withOpacity(0.4),
          backgroundColor: Colors.white,
          buttonBackgroundColor: const Color.fromARGB(255, 8, 6, 90),
          animationDuration: const Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _listPages[_page]);
  }
}
