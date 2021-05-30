import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/modules/home/ui/drawer.dart';
import 'package:app/src/modules/home/ui/recommendation_widget.dart';
import 'package:app/src/modules/user/ui/user_details_widget.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flyingwolf', style: Theme.of(context).textTheme.headline6, ),
        ),
        drawer: AppDrawer(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: AppTheme.kBodyPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SpacerWidget(AppTheme.kBodyPadding),
              UserDetailsWidget(),
              SpacerWidget(AppTheme.kBodyPadding),
              Expanded(child: RecommendationWidget())
            ],
          ),
        ),
      ),
    );
  }
}
