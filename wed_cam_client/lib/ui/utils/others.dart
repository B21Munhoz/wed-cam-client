import 'package:flutter/material.dart';
import 'my_palett.dart';


PreferredSizeWidget myAppBar(String title, List<Widget> actionsList) {
  AppBar a = new AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),
    actions: actionsList,
    backgroundColor: textPink,
  );
  return a;
}


PreferredSizeWidget myTabBar(String title, List<Widget> actionsList, List<Tab> tabsList) {
  AppBar a = new AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),
    actions: actionsList,
    bottom: TabBar(
      tabs: tabsList,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: goldenYellow),
      labelStyle: TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: bgPink,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: bgPink,
      ),

    ),
    backgroundColor: textPink,
  );
  return a;
}
