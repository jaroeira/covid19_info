import 'package:covid19_info/core/models/country_info.dart';
import 'package:flutter/material.dart';
import 'package:covid19_info/core/viewmodels/country_detail_view_model.dart';
import '../base_provider_view.dart';
import '../const.dart';
import 'package:charts_flutter/flutter.dart';

class CountryDetailScreen extends StatelessWidget {
  static const String id = 'CountryDetailScreen';

  final CountryInfo info;

  CountryDetailScreen({this.info});

  final List<SampleData> sampleDataList = [
    SampleData(
      cases: 12,
      recordDate: DateTime.utc(2020, DateTime.january, 1),
    ),
    SampleData(
      cases: 1000,
      recordDate: DateTime.utc(2020, DateTime.february, 1),
    ),
    SampleData(
      cases: 5000,
      recordDate: DateTime.utc(2020, DateTime.march, 1),
    ),
    SampleData(
      cases: 50000,
      recordDate: DateTime.utc(2020, DateTime.april, 1),
    ),
    SampleData(
      cases: 25000,
      recordDate: DateTime.utc(2020, DateTime.may, 1),
    ),
    SampleData(
      cases: 12,
      recordDate: DateTime.utc(2020, DateTime.june, 1),
    ),
    SampleData(
      cases: 1000,
      recordDate: DateTime.utc(2020, DateTime.july, 1),
    ),
  ];

  String getMonthAsString(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Fev';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Oct';
      default:
        return '';
    }
  }

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
                  Container(
                    width: double.infinity,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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

class SampleData {
  final int cases;
  final DateTime recordDate;

  SampleData({this.cases, this.recordDate});
}
