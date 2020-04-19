import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:flutter/material.dart';
import '../base_provider_view.dart';

class WorldCasesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProviderView<WorldCasesListViewModel>(
      modelCallBack: (model) {
        model.loadData();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Info App'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Top Country',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.top5ByCasesCountryInfoList.length,
                        itemBuilder: (context, index) {
                          CountryInfo info =
                              model.top5ByCasesCountryInfoList[index];
                          return _buildHorizontalReusableCard(info);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) {
                    model.filterText = value;
                  },
                ),
              ),
              Expanded(
                flex: 5,
                child: _buildState(model),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildState(WorldCasesListViewModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return Center(child: CircularProgressIndicator());
      case ViewState.Idle:
        return BuildListView(
          countryInfoList: model.countryInfoList,
          onRefreshCallBack: () async {
            await model.loadData();
          },
        );
      case ViewState.Error:
        return _buildErrorListView(model);
      default:
        return _buildErrorListView(model);
    }
  }

  Widget _buildErrorListView(WorldCasesListViewModel model) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await model.loadData();
        },
        child: ListView(
          children: <Widget>[
            Center(
              child: Text('Error loading data'),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text('Pull to refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalReusableCard(CountryInfo info) {
    return Container(
      width: 180.0,
      height: 120.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/${info.name.toLowerCase()}.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 5.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Cases'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Deaths'),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info.name),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 5.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Active'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 5.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Recovered'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  final List<CountryInfo> countryInfoList;
  final Function onRefreshCallBack;

  BuildListView({this.countryInfoList, this.onRefreshCallBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefreshCallBack,
            child: ListView.builder(
              itemCount: countryInfoList.length,
              itemBuilder: (context, index) {
                return _reusableCard(countryInfoList[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _reusableCard(CountryInfo info) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 90.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'images/${info.name.replaceAll(' ', '-').toLowerCase()}.png'),
                  ),
                  Text(info.name),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                Text('Cases'),
                Text(
                  info.numberOfCases,
                  style: TextStyle(color: Colors.purple),
                ),
                Text('Deaths'),
                Text(
                  info.numberOfDeaths,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                Text('Active'),
                Text(
                  info.activeCases,
                  style: TextStyle(color: Colors.indigo),
                ),
                Text('Recovered'),
                Text(
                  info.totalRecovered,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
