import 'package:app/src/services/utility.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/models/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OverlappedAppBar extends StatefulWidget {
  final Widget body;
  final scaffoldKey;
  final Widget drawer;
  final CustomAppBar customAppBar;
  final double topOverFlow;
  final double height;
  final Widget fab;
  OverlappedAppBar(
      {Key key,
      @required this.body,
      this.topOverFlow,
      this.drawer,
      this.scaffoldKey,
      this.height,
      this.fab,
      @required this.customAppBar})
      : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<OverlappedAppBar> {
  @override
  Widget build(BuildContext context) {
    double _topOverFlow = widget.topOverFlow ?? 0;
    final double _kAppBarHeight = widget.height ?? AppTheme.kAppBarHeight;

    Widget _title() {
      return Text(
        widget.customAppBar.title ?? '',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppTheme.kTitleFontSize),
      );
    }

    return Scaffold(
        drawer: widget.drawer,
        key: widget.scaffoldKey,
        floatingActionButton: widget.fab,
        body: Stack(
          children: [
            // Custom App Bar
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: SizedBox(
                  height: _kAppBarHeight,
                  width: Utility.displayWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                                  margin: EdgeInsets.only(
                                      top: _kAppBarHeight * .20),
                                  child: widget.customAppBar.leading) ??
                              Container(
                                height: 50,
                              ),
                          Container(
                              margin: EdgeInsets.only(top: 50),
                              child: widget.customAppBar.trailing ??
                                  Container(
                                    height: 50,
                                  ))
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: AppTheme.kBodyPadding),
                          child: _title()),
                    ],
                  )),
            ),
            Container(
                margin: EdgeInsets.only(top: _kAppBarHeight - _topOverFlow),
                child: widget.body)
          ],
        ));
  }
}
