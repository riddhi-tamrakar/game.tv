import 'package:app/src/styles/theme.dart';
import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: AppTheme.kBodyPadding),
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        ),
      ),
    );
  }
}
