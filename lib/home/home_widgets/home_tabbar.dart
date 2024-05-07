import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  final TabController tabController;
  const HomeTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 20),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 35),
            ),
          ),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            isScrollable: false,
            labelColor: Colors.red[700],
            unselectedLabelColor: const Color(0xff515c6f),
            tabs:  [
              tabButton(title: '최신제품'),
              tabButton(title: '인기칼럼'),
              tabButton(title: '데일리 문제'),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabButton({required String title}) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
