import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/screens/country_detail_screen.dart';
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
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(5),
        elevation: 15,
        child: Container(
          width: double.infinity,
          child: child != null
              ? child
              : Center(
                  child: Text('Data'),
                ),
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
            height: 130,
            item: item,
            onTap: () {
              Navigator.pushNamed(context, CountryDetailScreen.id,
                  arguments: item);
            },
          );
        },
      ),
    );
  }
}

class HorizontalCard extends StatelessWidget {
  final CountryInfo item;
  final double width;
  final double height;
  final Function onTap;

  HorizontalCard({this.item, this.width = 200, this.height = 180, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: Card(
          color: kHorizontalCardColor,
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
                      'images/flags/${item.isoCode.toLowerCase()}.png',
                      height: 50.0,
                      width: 50.0,
                    ),
                    SizedBox(height: 8.0),
                    DotLabel(
                      labelText: item.numberOfCases.toString(),
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
                      style: kLabelTextStyle,
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
          return VerticalCard(
            item: item,
            onTap: () {
              Navigator.pushNamed(context, CountryDetailScreen.id,
                  arguments: item);
            },
          );
        },
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  final CountryInfo item;
  final Function onTap;

  VerticalCard({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kVerticalCardColor,
        child: Container(
          height: 85,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/flags/${item.isoCode.toLowerCase()}.png',
                            height: 40.0,
                            width: 40.0,
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
                                labelText: item.numberOfCases.toString(),
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
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: kLabelTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionLabelRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        DotLabel(
          labelText: 'Cases',
          dotColor: Colors.purple,
        ),
        DotLabel(
          labelText: 'Deaths',
          dotColor: Colors.red,
        ),
        DotLabel(
          labelText: 'Active',
          dotColor: Colors.yellow,
        ),
        DotLabel(
          labelText: 'Recovered',
          dotColor: Colors.green,
        ),
      ],
    );
  }
}
