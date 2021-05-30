import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/modules/user/bloc/user_bloc.dart';
import 'package:app/src/modules/user/models/user.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/profile_picture_widget.dart';
import 'package:app/src/widgets/shimmer_loading_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsWidget extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsWidget> {
  UserBloc _bloc = new UserBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchUserDetails());
  }

  Widget _userInfo(User user) => Row(
        children: [
          ProfilePictureWidget(
            url: user.avatar ?? 'https://dummyimage.com/300/09f/fff.png',
            radius: 120,
          ),
          SpacerWidget(AppTheme.kBodyPadding),
          Column(
            children: [
              Text(user.name ?? '',
                  style: Theme.of(context).textTheme.headline5),
              SpacerWidget(AppTheme.kBodyPadding),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        user.ratings ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      SpacerWidget(8),
                      Text(
                        AppTranslations.of(context).text('ratings'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  ))
            ],
          )
        ],
      );

  Widget _item(String val1, String val2, Color color) => Container(
        height: 130,
        padding: EdgeInsets.symmetric(
            vertical: AppTheme.kBodyPadding,
            horizontal: AppTheme.kBodyPadding * 0.5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.7),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            //  center: Alignment(1.0, 1.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              val1,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).backgroundColor..withOpacity(0.9)),
            ),
            Text(
              val2,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).backgroundColor.withOpacity(0.9)),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget _gameScoreBoard(User user) => ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(AppTheme.kHomeItemBorderRadius)),
        child: Row(
          children: [
            Expanded(
              child: _item(user.totalTeammatesPalyed ?? '',  AppTranslations.of(context).text('teammates_played'),
                  Color(0xffe89100)),
            ),
            Expanded(
                child: _item(user.totalTeammatesWon ?? '',  AppTranslations.of(context).text('teammates_won'),
                    Color(0xff8a2be2))),
            Expanded(
                child: _item(
                    user.winningPercentage != null
                        ? user.winningPercentage + '%'
                        : '',
                   AppTranslations.of(context).text('winning_percentage'),
                    Color(0xffed6848))),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _bloc,
        builder: (BuildContext context, UserState state) {
          if (state is UserDataLoaded) {
            return Column(
              children: [
                _userInfo(state.data),
                SpacerWidget(AppTheme.kBodyPadding),
                _gameScoreBoard(state.data)
              ],
            );
          } 
          else if (state is Loading) {
            return ShimmerLoading(
                child: Column(
                  children: [
                    _userInfo(User()),
                    SpacerWidget(AppTheme.kBodyPadding),
                    _gameScoreBoard(User())
                  ],
                ),
                isLoading: true);
          }
           else {
            return Container();
          }
      
        });
  }
}
