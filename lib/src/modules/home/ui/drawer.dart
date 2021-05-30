import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/overrides.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/app_bar_with_overlapped_body.dart';
import 'package:app/src/widgets/back_button_widget.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/icon_selector.dart';
import 'package:app/src/widgets/models/custom_app_bar.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _navigate(item) {
      Navigator.pushNamed(context, item['path']);
    }

    Widget cardItem(item) => InkWell(
          onTap: () => _navigate(item),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: AppTheme.kBodyPadding),
            child: CustomCard(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconSelectorWidget(item['icon'], 'asset'),
                    SpacerWidget(AppTheme.kBodyPadding),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child:
                          Text(AppTranslations.of(context).text(item['title'])),
                    )
                  ]),
            ),
          ),
        );

    return OverlappedAppBar(
      topOverFlow: 40,
      customAppBar: CustomAppBar(
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(useCrossIcon: true),
        ),
      ),
      body: Container(
        child: GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          children: List.generate(Overrides.drawerItems.length, (index) {
            return cardItem(Overrides.drawerItems[index]);
          }),
        ),
      ),
    );
  }
}
