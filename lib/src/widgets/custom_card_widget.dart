import 'package:app/src/styles/theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final double radius;

  CustomCard({
    Key key,
    this.color,
    this.radius,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius ?? AppTheme.kBorderRadius),
              topRight: Radius.circular(radius ?? AppTheme.kBorderRadius),
              bottomLeft: Radius.circular(radius ?? AppTheme.kBorderRadius),
              bottomRight: Radius.circular(radius ?? AppTheme.kBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        // height: height ?? 250,
        child: child);
  }
}
