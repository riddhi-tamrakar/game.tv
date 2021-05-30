import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final bool useCrossIcon;
  BackButtonWidget({this.useCrossIcon});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Theme.of(context).colorScheme.onPrimary,
        icon: Icon(
          useCrossIcon == true ? Icons.close : Icons.keyboard_arrow_left,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}
