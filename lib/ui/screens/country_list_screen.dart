import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CountryListScreen extends StatelessWidget {
  final WorldCasesListViewModel model;

  CountryListScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (newValue) {
              model.filterText = newValue;
            },
          ),
          Expanded(
            child: VerticalListView(
              itemsList: model.countryInfoList,
            ),
          ),
        ],
      ),
    );
  }
}
