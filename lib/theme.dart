import 'package:flutter/material.dart';
import 'package:store_app/constants.dart';

ThemeData themeData() {
  return ThemeData(
    tabBarTheme: TabBarThemeData(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashBorderRadius: BorderRadius.circular(12),
      // indicatorAnimation: TabIndicatorAnimation.elastic,
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent,
      labelColor: kColor0,
      // unselectedLabelColor: kColor900,
      // indicatorSize: TabBarIndicatorSize.tab,
      // labelPadding: EdgeInsets.all(0),
      indicator: ShapeDecoration(
        color: kColor900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      tabAlignment: TabAlignment.start,
    ),
    scaffoldBackgroundColor: kColor0,
    fontFamily: 'RationalDisplayLight',
    // brightness: Brightness.light,
    // primaryColor: kColor0,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: Size(double.infinity, 56),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: kColor900,
      onPrimary: kColor0,
      secondary: kColor800,
      onSecondary: kColor0,
      error: Colors.red,
      onError: kColor0,
      surface: kColor0,
      onSurface: kColor900,
    ),
  );
}
