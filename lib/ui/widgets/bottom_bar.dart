import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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

// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(FontAwesomeIcons.globe),
//                   onPressed: () {},
//                 ),
//                 Text('World'),
//               ],
//             ),
//             Column(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(FontAwesomeIcons.list),
//                   onPressed: null,
//                 ),
//                 Text('Cases by country'),
//               ],
//             ),
//           ],
//         ),
