import 'package:calmvas/home/ItemsList.dart';
import 'package:flutter/material.dart';

class HomeTabBarView extends StatelessWidget {
  final TabController tabController;
  const HomeTabBarView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 750,
      child: TabBarView(
        controller: tabController,
        children: [
          ItemsList(title: "RECENT"),
          ItemsList(title: "POPULAR"),
          ItemsList(title: "DAILY")
        ],
      ),
    );
  }
}
