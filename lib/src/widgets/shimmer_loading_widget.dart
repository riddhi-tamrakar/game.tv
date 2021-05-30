import 'package:app/src/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  ShimmerLoading({Key key, @required this.child, @required this.isLoading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: AppTheme.kShimmerBaseColor,
            highlightColor: AppTheme.kShimmerHighlightColor,
            enabled: true,
            child: child)
        : child;
  }
}
