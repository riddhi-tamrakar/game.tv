import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String url;
  final double radius;

  ProfilePictureWidget({Key key, this.radius, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius != null ? radius : 30,
      width: radius != null ? radius : 30,
      child: Container(
          child: Center(
              child: CachedNetworkImage(
        height: radius != null ? radius : 30,
        width: radius != null ? radius : 30,
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius != null ? radius : 30,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ))),
    );
  }
}
