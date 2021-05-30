import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/modules/home/bloc/bloc/home_bloc.dart';
import 'package:app/src/modules/home/models/tournament.dart';
import 'package:app/src/services/utility.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/bottom-loader.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/shimmer_loading_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationWidget extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationWidget> {
  HomeBloc _bloc = HomeBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchRecommentations());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll > (maxScroll - 100)) {
      if (!mounted) return;
      _bloc.add(FetchMoreRecommentations());
    }
  }

  Widget _listItem(Tournament item) => Container(
        margin: EdgeInsets.only(
          bottom: AppTheme.kBodyPadding,
        ),
        child: CustomCard(
          radius: AppTheme.kHomeItemBorderRadius,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.kHomeItemBorderRadius),
                  topRight: Radius.circular(AppTheme.kHomeItemBorderRadius),
                ),
                child: SizedBox(
                    child: item.coverUrl != null && item.coverUrl != ''
                        ? CachedNetworkImage(
                            width: Utility.displayWidth(context),
                            height: 120,
                            fit: BoxFit.cover,
                            imageUrl: item.coverUrl,
                          )
                        : SizedBox(
                            width: Utility.displayWidth(context),
                            height: 120,
                          )),
              ),
              Container(
                  child: ListTile(
                title: Text(item.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(item.gameName ?? '',
                    style: Theme.of(context).textTheme.subtitle1),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 32,
                ),
              ))
            ],
          ),
        ),
      );

  Widget _fakeList() => Expanded(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, i) {
              return ShimmerLoading(
                  isLoading: true, child: _listItem(Tournament()));
            }),
      );

  Widget _list() => BlocBuilder<HomeBloc, HomeState>(
      bloc: _bloc,
      builder: (BuildContext context, HomeState state) {
        if (state is DataLoaded) {
          return Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: state.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.data.length) {
                    return _listItem(state.data[0]);
                  } else {
                    return state.hasReachedMax ? Container() : BottomLoader();
                  }
                }),
          );
        } else if (state is Loading || state is HomeInitial) {
          return _fakeList();
        } else if(state is ErrorReceived){
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top : AppTheme.kBodyPadding),
              child: Text(state.err ?? 'Something went wrong.', style: Theme.of(context).textTheme.caption,),
            ),
          );
        }else {
          return Container();
        }
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTranslations.of(context).text('recommeded_for_you'),
            style: Theme.of(context).textTheme.headline5),
        SpacerWidget(AppTheme.kBodyPadding),
        _list()
      ],
    );
  }
}
