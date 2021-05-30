import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover, width: 250,);
  }
}