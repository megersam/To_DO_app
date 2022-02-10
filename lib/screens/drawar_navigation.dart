import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/home_screen.dart';

import 'categories_screen.dart';
class DrawerNavigation extends StatefulWidget{
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}
class _DrawerNavigationState extends State<DrawerNavigation>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  ""
                ),
              ),
              accountName: Text("Megersa"),
              accountEmail: Text("megibiratu@gmail.com"),
            decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
            leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }

}