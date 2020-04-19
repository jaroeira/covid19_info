import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:flutter/material.dart';

class FixedHeightContainer extends StatelessWidget {
  final double height;
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;

  FixedHeightContainer({this.height, this.child, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Container(
        padding: padding,
        child: child,
        color: color,
      ),
    );
  }
}

class RoundCornerContainer extends StatelessWidget {
  final double height;
  final Color color;
  final Widget child;
  final LinearGradient gradient;

  RoundCornerContainer(
      {this.height = 50.0, this.color, this.child, this.gradient});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: child != null
            ? child
            : Center(
                child: Text('Data'),
              ),
      ),
    );
  }
}

class DotLabel extends StatelessWidget {
  final Color dotColor;
  final String labelText;

  DotLabel({this.labelText, this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: dotColor,
          radius: 5.0,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          labelText,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}

class HorizontalListView extends StatelessWidget {
  final List<CountryInfo> itemsList;

  HorizontalListView({this.itemsList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          CountryInfo item = itemsList[index];
          return HorizontalCard(
            item: item,
          );
        },
      ),
    );
  }
}

class HorizontalCard extends StatelessWidget {
  final CountryInfo item;

  HorizontalCard({this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 180,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: 180,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/${item.name.toLowerCase()}.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  SizedBox(height: 8.0),
                  DotLabel(
                    labelText: item.numberOfCases,
                    dotColor: Colors.purple,
                  ),
                  SizedBox(height: 8.0),
                  DotLabel(
                    labelText: item.numberOfDeaths,
                    dotColor: Colors.red,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  DotLabel(
                    labelText: item.activeCases,
                    dotColor: Colors.yellow,
                  ),
                  SizedBox(height: 8.0),
                  DotLabel(
                    labelText: item.totalRecovered,
                    dotColor: Colors.green,
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

class VerticalListView extends StatelessWidget {
  final List<CountryInfo> itemsList;

  VerticalListView({this.itemsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          final item = itemsList[index];
          return VerticalCard(item: item);
        },
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  final CountryInfo item;

  VerticalCard({this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('images/${item.name.toLowerCase()}.png'),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DotLabel(
                          labelText: item.numberOfCases,
                          dotColor: Colors.purple,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        DotLabel(
                          labelText: item.numberOfDeaths,
                          dotColor: Colors.red,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DotLabel(
                          labelText: item.activeCases,
                          dotColor: Colors.yellow,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        DotLabel(
                          labelText: item.totalRecovered,
                          dotColor: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
