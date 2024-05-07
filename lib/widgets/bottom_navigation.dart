import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // width: MediaQuery.of(context).size.width / 2 - 20.0,
                children: [
                  button(
                    context: context,
                    icon: Icons.alarm,
                    // routeName: '/alarm',
                    routeName: '/home',
                    currentRoute: currentRoute,
                  ),
                  button(
                    context: context,
                    icon: Icons.person_outline,
                    routeName: '/body',
                    currentRoute: currentRoute,
                  ),
                  const SizedBox(width: 28),
                  button(
                      context: context,
                      icon: Icons.search,
                      routeName: '/search',
                      currentRoute: currentRoute),
                  button(
                      context: context,
                      icon: Icons.shopping_basket,
                      routeName: '/cart',
                      currentRoute: currentRoute),
                ])));
  }

  Widget button({
    required BuildContext context,
    required IconData icon,
    required String? routeName,
    required String? currentRoute,
  }) {
    final isSelected = currentRoute == routeName;
    final buttonColor = isSelected ? Colors.red[700] : const Color(0xFF676E79);

    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.of(context).pushNamed(routeName ?? '');
      },
      color: buttonColor,
    );
  }
}
