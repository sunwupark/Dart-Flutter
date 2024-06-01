import 'package:calmvas/body/body_detail_page.dart';
import 'package:calmvas/widgets/appbars.dart';
import 'package:calmvas/widgets/bottom_navigation.dart';
import 'package:calmvas/widgets/floating_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageAppBar(context: context, title: '부위별 마사지'),
      body: SafeArea(
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          children: [
            BodyItem(title: "EYES", imgPath: 'assets/eye.jpeg'),
            BodyItem(title: "FACE", imgPath: 'assets/cheek.png'),
            BodyItem(title: "CHIN", imgPath: 'assets/chin2.jpeg'),
            BodyItem(title: "EARS", imgPath: 'assets/ears2.jpeg'),
          ],
        ),
      ),
      floatingActionButton: const FloatingCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BodyItem extends StatelessWidget {
  final String title;
  final String imgPath;
  const BodyItem({super.key, required this.title, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        (MediaQuery.of(context).size.width - 12 * 2 - 16) / 2;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BodyDetailPage(
            title: title
          )
        ));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: itemWidth,
              height: itemWidth - 36,
              child: Image.asset(imgPath, fit: BoxFit.cover),
            ),
            SizedBox(
              height: 36,
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
