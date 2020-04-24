import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CountryListScreen extends StatelessWidget {
  static const String id = 'CountryListScreen';

  final WorldCasesListViewModel model;

  CountryListScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: kPrimaryColor,
      padding: EdgeInsets.all(5.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: kLabelTextStyle,
              decoration: kSearchTextFieldtDecoration,
              onChanged: (newValue) {
                model.filterText = newValue;
              },
            ),
          ),
          kDefaultVerticalSpacer,
          DescriptionLabelRow(),
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
