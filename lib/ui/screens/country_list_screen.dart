import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CountryListScreen extends StatefulWidget {
  static const String id = 'CountryListScreen';

  final WorldCasesListViewModel model;

  CountryListScreen({this.model});

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController _textEditingController = TextEditingController();

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
              controller: _textEditingController,
              style: kLabelTextStyle,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Enter country name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide.none,
                ),
                suffix: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 15,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _textEditingController.clear();
                    widget.model.filterText = '';
                  },
                ),
              ),
              onChanged: (newValue) {
                widget.model.filterText = newValue;
              },
            ),
          ),
          kDefaultVerticalSpacer,
          DescriptionLabelRow(),
          Expanded(
            child: VerticalListView(
              itemsList: widget.model.countryInfoList,
            ),
          ),
        ],
      ),
    );
  }
}
