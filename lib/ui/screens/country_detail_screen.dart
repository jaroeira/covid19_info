import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/chart_data.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:flutter/material.dart';
import 'package:covid19_info/core/viewmodels/country_detail_view_model.dart';
import '../base_provider_view.dart';
import '../const.dart';
import 'package:charts_flutter/flutter.dart' as charts;

enum ChartSerieType {
  TotalCases,
  TotalDeaths,
  TotalRecovered,
  NewCases,
}

class CountryDetailScreen extends StatefulWidget {
  static const String id = 'CountryDetailScreen';

  final CountryInfo info;

  CountryDetailScreen({this.info});

  @override
  _CountryDetailScreenState createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseProviderView<CountryDetailViewModel>(
      modelCallBack: (model) async {
        model.loadData(countryName: widget.info.name);
      },
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              title: Text(
                'Covid-19 Info',
                style: kAppBarTitleStyle,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.navigate_before,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: kHorizontalCardColor,
                      elevation: 9,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  widget.info.name,
                                  style: kTitleTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'images/flags/${widget.info.isoCode.toLowerCase()}.png',
                                  width: 128,
                                  height: 128,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Confirmed cases: ${widget.info.numberOfCases}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Confirmed deaths: ${widget.info.numberOfDeaths}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Recovered: ${widget.info.totalRecovered}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Active cases: ${widget.info.activeCases}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: kAccentColor,
                        isScrollable: true,
                        labelColor: kTextIconColor,
                        unselectedLabelColor: kAccentColor,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'Total Cases',
                              style: kLabelTextStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Total Deaths',
                              style: kLabelTextStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Total Recovered',
                              style: kLabelTextStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'New Cases',
                              style: kLabelTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ChartNumbersByCase(
                          model: model,
                          type: ChartSerieType.TotalCases,
                        ),
                        ChartNumbersByCase(
                          model: model,
                          type: ChartSerieType.TotalDeaths,
                        ),
                        ChartNumbersByCase(
                          model: model,
                          type: ChartSerieType.TotalRecovered,
                        ),
                        ChartNumbersByCase(
                          model: model,
                          type: ChartSerieType.NewCases,
                        ),
                      ],
                    ),
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

class ChartNumbersByCase extends StatelessWidget {
  final CountryDetailViewModel model;
  final ChartSerieType type;

  ChartNumbersByCase({@required this.model, @required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildChart(model, type),
      ),
    );
  }

  Widget _buildChart(CountryDetailViewModel model, ChartSerieType type) {
    if (model.state == ViewState.Busy) {
      return Center(child: CircularProgressIndicator());
    } else if (model.dataList.length == 0) {
      return Center(child: Text('No chart data available'));
    } else {
      return charts.TimeSeriesChart(
        getChartDataList(model.dataList, type),
        animate: true,
        dateTimeFactory: charts.LocalDateTimeFactory(),
      );
    }
  }

  List<charts.Series<ChartData, DateTime>> getChartDataList(
      List<ChartData> dataList, ChartSerieType type) {
    Map<ChartSerieType, charts.Series<ChartData, DateTime>> chartSeries = {
      ChartSerieType.TotalCases: charts.Series<ChartData, DateTime>(
        id: 'totalCases',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (ChartData data, _) => data.recordDate,
        measureFn: (ChartData data, _) => data.cases,
        data: dataList,
      ),
      ChartSerieType.TotalDeaths: charts.Series<ChartData, DateTime>(
        id: 'totalDeaths',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartData data, _) => data.recordDate,
        measureFn: (ChartData data, _) => data.totalDeaths,
        data: dataList,
      ),
      ChartSerieType.TotalRecovered: charts.Series<ChartData, DateTime>(
        id: 'totalRecovered',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (ChartData data, _) => data.recordDate,
        measureFn: (ChartData data, _) => data.totalRecovered,
        data: dataList,
      ),
      ChartSerieType.NewCases: charts.Series<ChartData, DateTime>(
        id: 'newCases',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (ChartData data, _) => data.recordDate,
        measureFn: (ChartData data, _) => data.newCases,
        data: dataList,
      )
    };

    return [chartSeries[type]];
  }
}
