import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import 'country_detail_screen.dart';

class WorldInfoScreen extends StatelessWidget {
  static const String id = 'WorldInfoScreen';

  final WorldCasesListViewModel model;
  final bool isRefreshing;

  WorldInfoScreen({this.model, this.isRefreshing = false});

  @override
  Widget build(BuildContext context) {
    return _buildState(context, model);
  }

  Widget _buildState(BuildContext context, WorldCasesListViewModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return !isRefreshing
            ? Container(
                child: Center(child: CircularProgressIndicator()),
                height: 400,
              )
            : Container();
      case ViewState.Idle:
        return _buildMainComponent(context, model);
      case ViewState.Error:
        return _buildErrorListView(model);
      default:
        return _buildErrorListView(model);
    }
  }

  Widget _buildErrorListView(WorldCasesListViewModel model) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.update),
                Text(
                  'Error - Check your data connection',
                  style: kLabelTextStyle,
                ),
                Text(
                  'Pull to refresh',
                  style: kLabelTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainComponent(
      BuildContext context, WorldCasesListViewModel model) {
    return Container(
      //color: kPrimaryColor,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FixedHeightContainer(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Live Statistics',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Confirmed, death, recovered and active',
                  style: kLabelTextStyle,
                ),
                Text(
                  'Updated on ${model.worldInfo.statisticDateAsString}',
                  style: kLabelTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          FixedHeightContainer(
            height: 155,
            child: Column(
              children: <Widget>[
                RoundCornerContainer(
                  height: 80.0,
                  color: kAccentColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        model.worldInfo.totalCases,
                        style: kBigPanelTextSyle.copyWith(
                            fontSize: 30.0, fontWeight: FontWeight.w900),
                      ),
                      kDefaultVerticalSpacer,
                      Text(
                        'Confirmed Cases',
                        style: kBigPanelTextSyle,
                      ),
                    ],
                  ),
                ),
                kDefaultVerticalSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: RoundCornerContainer(
                        color: kAccentColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              model.worldInfo.totalDeaths,
                              style: kSmalPanelTextStyle,
                            ),
                            Text(
                              'Deaths',
                              style: kSmalPanelTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    kDefaultHorizontallSpacer,
                    Expanded(
                      child: RoundCornerContainer(
                        color: kAccentColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              model.worldInfo.totalRecovered,
                              style: kSmalPanelTextStyle,
                            ),
                            Text(
                              'Recovered',
                              style: kSmalPanelTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kDefaultVerticalSpacer,
          DescriptionLabelRow(),
          kDefaultVerticalSpacer,
          model.hasUserLocation()
              ? FixedHeightContainer(
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Location',
                        style: kTitleTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HorizontalCard(
                        height: 130,
                        item: model.userLocation,
                        onTap: () {
                          Navigator.pushNamed(context, CountryDetailScreen.id,
                              arguments: model.userLocation);
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          FixedHeightContainer(
            height: 165,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Top Country',
                  style: kTitleTextStyle,
                ),
                kDefaultVerticalSpacer,
                HorizontalListView(
                  itemsList: model.top5ByCasesCountryInfoList,
                ),
              ],
            ),
          ),
          kDefaultVerticalSpacer,
        ],
      ),
    );
  }
}
