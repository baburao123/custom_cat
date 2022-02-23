import 'package:flutter/material.dart';

class UserOrderLandingScreen extends StatefulWidget {
  @override
  _UserOrderLandingScreenState createState() => _UserOrderLandingScreenState();
}

class _UserOrderLandingScreenState extends State<UserOrderLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(   "Your Orders"),  ),
      body: Center(child: Text("Coming Soon..!!"),),
    );
  }
}
