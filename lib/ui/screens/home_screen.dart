import 'package:covid19_info/core/viewmodels/world_cases_list_view_model.dart';
import 'package:covid19_info/ui/screens/country_list_screen.dart';
import 'package:covid19_info/ui/screens/world_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../base_provider_view.dart';
import 'package:covid19_info/ui/const.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseProviderView<WorldCasesListViewModel>(
      modelCallBack: (model) {
        isRefreshing = true;
        model.loadData();
      },
      builder: (context, model, child) => Scaffold(
        body: RefreshIndicator(
          displacement: 400,
          onRefresh: () async {
            await model.loadData();
          },
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                title: Text(
                  'Covid-19 Info App',
                  style: kAppBarTextTitleStyle,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        WorldInfoScreen(
                          model: model,
                          isRefreshing: isRefreshing,
                        ),
                        CountryListScreen(
                          model: model,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      elevation: 9.0,
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xFFCDCDCD),
          controller: _tabController,
          tabs: <Widget>[
            _buildTab(FontAwesomeIcons.globe, 'World'),
            _buildTab(FontAwesomeIcons.list, 'Cases by country'),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData iconData, String labelText) {
    return Tab(
      child: Column(
        children: <Widget>[
          Icon(iconData),
          SizedBox(
            height: 5.0,
          ),
          Text(labelText),
        ],
      ),
    );
  }
}
