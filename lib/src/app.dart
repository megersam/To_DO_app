import 'package:flutter/material.dart';
import 'package:todo/screens/home_screen.dart';
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),  // calling the home screen first for the app launch.
    );
  }
}