import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ttb_restapi/screens/home_screen.dart';
import 'package:ttb_restapi/screens/login_screen.dart';
import 'package:ttb_restapi/screens/photos.dart';
import 'package:ttb_restapi/screens/productScreenComplexJson.dart';
import 'package:ttb_restapi/screens/signup_screen.dart';
import 'package:ttb_restapi/screens/upload_image.dart';
import 'package:ttb_restapi/screens/user_screen_without_model.dart';
import 'package:ttb_restapi/screens/users_screen.dart';
class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List screens =[
    null,
    HomeScreen(),
    Photos(),
    UsersScreen(),
    UserScreenWithoutModel(),
    Productscreencomplexjson(),
  ];
  int _currentIndex = 3;
  void changeIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: screens.elementAt(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,animationDuration: Duration(milliseconds: 200),buttonBackgroundColor: Colors.blueGrey.shade500,
          backgroundColor: Colors.blueGrey.shade200,
          items: [
            IconButton(onPressed: getdrawer, icon: Icon(Icons.menu)),
            Icon(Icons.home),
            Icon(Icons.photo),
            Icon(Icons.person),
            Icon(Icons.person_add_disabled),
            Icon(Icons.shopping_bag),
            //Icon(Icons.login,color: Colors.orange,),
          ],
        onTap: changeIndex,
        index: _currentIndex,
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal.shade600,
        surfaceTintColor: Colors.yellow,
        width: MediaQuery.of(context).size.width * .7,
        child: ListView(
        children: [
        DrawerHeader(child: Text("Menu",style: TextStyle(color: Colors.white,fontSize: 20),),),
        Card(color: Colors.teal.shade300,elevation: 5,
          child: ListTile(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
              },
            title: Text("Login"),
            leading: Icon(Icons.login),
          ),
        ),
        Card(color: Colors.teal.shade300,elevation: 5,
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> SignupScreen()));
            },
            title: Text("Register"),
            leading: Icon(Icons.report_gmailerrorred),

          ),
        ),
        Card(color: Colors.teal.shade300,elevation: 5,
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> UploadImage()));
            },
            title: Text("Upload Image"),
            leading: Icon(Icons.camera_alt_outlined),

          ),
        ),
              ],),),
    );
  }

  void getdrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
}
