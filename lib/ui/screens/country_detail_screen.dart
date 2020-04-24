import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/chart_data.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:flutter/material.dart';
import 'package:covid19_info/core/viewmodels/country_detail_view_model.dart';
import '../base_provider_view.dart';
import '../const.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryDetailScreen extends StatelessWidget {
  static const String id = 'CountryDetailScreen';

  final CountryInfo info;

  CountryDetailScreen({this.info});

  @override
  Widget build(BuildContext context) {
    return BaseProviderView<CountryDetailViewModel>(
      modelCallBack: (model) async {
        model.loadData(countryName: info.name);
      },
      builder: (context, model, child) => Scaffold(
        //backgroundColor: kPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              title: Text(
                'Covid-19 Info App',
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
                                  info.name,
                                  style: kTitleTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'images/flags/${info.isoCode.toLowerCase()}.png',
                                  width: 128,
                                  height: 128,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Confirmed cases: ${info.numberOfCases}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Confirmed deaths: ${info.numberOfDeaths}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Recovered: ${info.totalRecovered}',
                                      style: kLabelTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kDefaultVerticalSpacer,
                                    Text(
                                      'Active cases: ${info.activeCases}',
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
                  Center(
                    child: Text(
                      'History of confirmed cases',
                      style: kLabelTextStyle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _buildChart(model),
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

  Widget _buildChart(CountryDetailViewModel model) {
    if (model.state == ViewState.Busy) {
      return Center(child: CircularProgressIndicator());
    } else if (model.dataList.length == 0) {
      return Center(child: Text('No chart data available'));
    } else {
      return charts.TimeSeriesChart(
        getChartDataList(model.dataList),
        animate: true,
        dateTimeFactory: charts.LocalDateTimeFactory(),
      );
    }
  }

  List<charts.Series<ChartData, DateTime>> getChartDataList(
      List<ChartData> dataList) {
    return [
      charts.Series<ChartData, DateTime>(
        id: 'Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData data, _) => data.recordDate,
        measureFn: (ChartData data, _) => data.cases,
        data: dataList,
      )
    ];
  }
}
