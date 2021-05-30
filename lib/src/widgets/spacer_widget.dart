import 'package:flutter/material.dart';

class SpacerWidget extends StatelessWidget {
  final double space;
  SpacerWidget(this.space);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
      width: space,
    );
  }
}