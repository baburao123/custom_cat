import 'package:flutter/material.dart';
import './user_cart_screen.dart';

class UserCartLandingScreen extends StatefulWidget {
  @override
  _UserCartLandingScreenState createState() => _UserCartLandingScreenState();
}

class _UserCartLandingScreenState extends State<UserCartLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Cart",
              textAlign: TextAlign.center,
            ),
          ),
          body: UserCardScreen(),
        ));
  }
}
