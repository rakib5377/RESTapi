import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ttb_restapi/screens/home_screen.dart';
import 'package:ttb_restapi/screens/photos.dart';
import 'package:ttb_restapi/screens/productScreenComplexJson.dart';
import 'package:ttb_restapi/screens/user_screen_without_model.dart';
import 'package:ttb_restapi/screens/users_screen.dart';
class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List screens =[
    HomeScreen(),
    Photos(),
    UsersScreen(),
    UserScreenWithoutModel(),
    Productscreencomplexjson(),
  ];
  int _currentIndex = 0;
  void changeIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,animationDuration: Duration(milliseconds: 200),buttonBackgroundColor: Colors.blueGrey.shade500,
          backgroundColor: Colors.blueGrey.shade200,
          items: [
            Icon(Icons.home),
            Icon(Icons.photo),
            Icon(Icons.person),
            Icon(Icons.person_add_disabled),
            Icon(Icons.shopping_bag),
          ],
        onTap: changeIndex,
        index: _currentIndex,
      ),
    );
  }
}
