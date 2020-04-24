import 'package:flutter/material.dart';

const kAppBarTitleStyle = TextStyle(
  fontFamily: 'Muli',
  //color: Color(0xFFFEFEFF),
);

const kTitleTextStyle = TextStyle(
  fontFamily: 'Muli',
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryTextColor,
);

const kLabelTextStyle = TextStyle(
  fontFamily: 'Muli',
  color: kSecondaryTextColor,
  fontSize: 12,
);

const kDefaultVerticalSpacer = SizedBox(
  height: 5.0,
);

const kDefaultHorizontallSpacer = SizedBox(
  width: 5.0,
);

const kBigPanelTextSyle = TextStyle(
  fontFamily: 'Muli',
  color: kLightTextColor,
  fontSize: 18.0,
);

const kSmalPanelTextStyle = TextStyle(
  fontFamily: 'Muli',
  color: kLightTextColor,
  fontSize: 15.0,
);

const kTabBarLabelTextStyle = TextStyle(
  color: kTextIconColor,
  fontFamily: 'Muli',
  fontSize: 12,
);

//Search Text Field
const kSearchTextFieldtDecoration = InputDecoration(
  icon: Icon(
    Icons.search,
    color: Colors.grey,
  ),
  hintText: 'Enter country name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

//Colors
const kPrimaryColor = Color(0xFF607D8B);
const kAccentColor = Color(0xFF9E9E9E);

const kDarkPrimaryColor = Color(0xFF455A64);
const kLightPrimaryColor = Color(0xFFCFD8DC);

const kTextIconColor = Color(0xFFFFFFFF);
const kPrimaryTextColor = Color(0xFF212121);
const kSecondaryTextColor = Color(0xFF757575);
const kLightTextColor = Color(0xFFFFFFFF);
const kDividerColor = Color(0xFFBDBDBD);

const kHorizontalCardColor = Colors.white;
const kVerticalCardColor = Colors.white;
