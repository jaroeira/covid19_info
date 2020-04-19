import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:flutter/material.dart';
import '../base_provider_view.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProviderView<WorldCasesListViewModel>(
      modelCallBack: (model) {
        model.loadData();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Covid-19 Info App',
            style: kAppBarTextTitleStyle,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await model.loadData();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _buildState(context, model),
          ),
        ),
      ),
    );
  }

  Widget _buildMainComponent(
      BuildContext context, WorldCasesListViewModel model) {
    return Container(
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
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xFFF2C64C),
                      Color(0xFFF29C4A),
                    ],
                  ),
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
                        gradient: LinearGradient(colors: const [
                          Color(0xFF190807),
                          Color(0xFFD04435),
                        ]),
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
                        gradient: LinearGradient(colors: const [
                          Color(0xFF37935D),
                          Color(0xFF53B1C7),
                        ]),
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
          FixedHeightContainer(
            height: 185,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Top Country',
                  style: kTitleTextStyle,
                ),
                kDefaultVerticalSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DotLabel(
                      labelText: 'Cases',
                      dotColor: Colors.purple,
                    ),
                    DotLabel(
                      labelText: 'Deaths',
                      dotColor: Colors.red,
                    ),
                    DotLabel(
                      labelText: 'Active',
                      dotColor: Colors.yellow,
                    ),
                    DotLabel(
                      labelText: 'Recovered',
                      dotColor: Colors.green,
                    ),
                  ],
                ),
                kDefaultVerticalSpacer,
                HorizontalListView(
                  itemsList: model.top5ByCasesCountryInfoList,
                ),
              ],
            ),
          ),
          kDefaultVerticalSpacer,
          FixedHeightContainer(
            height: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                kDefaultVerticalSpacer,
                Text(
                  'Other Country',
                  style: kTitleTextStyle,
                ),
                kDefaultVerticalSpacer,
                Expanded(
                  child: VerticalListView(
                    itemsList: model.countryInfoList,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildState(BuildContext context, WorldCasesListViewModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return Container(child: Center(child: CircularProgressIndicator()));
      case ViewState.Idle:
        return _buildMainComponent(context, model);
      case ViewState.Error:
        return _buildErrorListView(model);
      default:
        return _buildErrorListView(model);
    }
  }

  Widget _buildErrorListView(WorldCasesListViewModel model) {
    return RefreshIndicator(
      onRefresh: () async {
        await model.loadData();
      },
      child: SizedBox(
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
      ),
    );
  }
}
