import 'package:calmvas/home/home_tabbar_view.dart';
import 'package:calmvas/widgets/bottom_navigation.dart';
import 'package:calmvas/home/home_widgets/home_carousel.dart';
import 'package:calmvas/home/home_widgets/home_tabbar.dart';
import 'package:calmvas/widgets/appbars.dart';
import 'package:calmvas/widgets/floating_cart_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            HomeCarousel(),
            HomeTabBar(tabController: tabController),
            HomeTabBarView(tabController: tabController),
          ],
        ),
      ),
      floatingActionButton: const FloatingCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
