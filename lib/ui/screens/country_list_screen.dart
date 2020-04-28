import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:covid19_info/core/enums/country_info_list_sort_type.dart';

class CountryListScreen extends StatefulWidget {
  static const String id = 'CountryListScreen';

  final WorldCasesListViewModel model;

  CountryListScreen({this.model});

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController _textEditingController = TextEditingController();

  CountryInfoListSortType sortedByValue = CountryInfoListSortType.Cases;

  ScrollController _listViewController;

  @override
  void initState() {
    super.initState();
    _listViewController = ScrollController();
  }

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
          kDefaultVerticalSpacer,
          _buildSortComponent(),
          Expanded(
            child: VerticalListView(
              controller: _listViewController,
              itemsList: widget.model.countryInfoList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortComponent() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sorted by',
            style: kLabelTextStyle,
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton(
              value: sortedByValue,
              icon: Icon(Icons.sort),
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Text(
                    'Name',
                    style: kLabelTextStyle,
                  ),
                  value: CountryInfoListSortType.Name,
                ),
                DropdownMenuItem(
                  child: Text(
                    'Cases',
                    style: kLabelTextStyle,
                  ),
                  value: CountryInfoListSortType.Cases,
                ),
                DropdownMenuItem(
                  child: Text(
                    'Deaths',
                    style: kLabelTextStyle,
                  ),
                  value: CountryInfoListSortType.Deaths,
                ),
                DropdownMenuItem(
                  child: Text(
                    'Active',
                    style: kLabelTextStyle,
                  ),
                  value: CountryInfoListSortType.Active,
                ),
                DropdownMenuItem(
                  child: Text(
                    'Recovered',
                    style: kLabelTextStyle,
                  ),
                  value: CountryInfoListSortType.Recovered,
                ),
              ],
              onChanged: (sortType) {
                sortedByValue = sortType;
                widget.model.sortCountryList(sortType);
                _listViewController
                  ..animateTo(0.0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
              }),
          IconButton(
              icon: Icon(
                Icons.swap_vert,
                color: kSecondaryTextColor,
              ),
              onPressed: () {
                widget.model.toggleSortOder();
              }),
        ],
      ),
    );
  }
}
