import 'package:calmvas/home/all_items_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ItemDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemsList extends StatefulWidget {
  final String title;

  const ItemsList({super.key, required this.title});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  List<String> products = [];
  List<CustomItem> items = [
    CustomItem(name: 'Item3', price: '\$12.3', imgPath: 'assets/item3.jpeg'),
    CustomItem(name: 'Item4', price: '\$10.99', imgPath: 'assets/item4.jpeg'),
  ];
  List<CustomItem> columns = [
    CustomItem(name: 'columns', price: '\$12.3', imgPath: 'assets/item3.jpeg'),
    CustomItem(name: 'column', price: '\$10.99', imgPath: 'assets/item4.jpeg'),
  ];
  List<CustomItem> daily = [
    CustomItem(name: 'daily', price: '\$12.3', imgPath: 'assets/item3.jpeg'),
    CustomItem(name: 'daily', price: '\$10.99', imgPath: 'assets/item4.jpeg'),
  ];

  @override
  void initState() {
    super.initState();
    String title = widget.title;
    fetchItems();
    setState(() {
      products;
    });
  }

  Future<void> fetchItems({name = String}) async {
    // you can replace your api link with this link
    final response = await http.get(Uri.parse('http://localhost:3000/' + name));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        var response2 = await http
            .get(Uri.parse('http://localhost:3000/${name}/${jsonData[i]}'));
        if (response2.statusCode == 200) {
          print(json.decode(response2.body)["publicUrl"]);
          print("WIRKI?NG?");
          products.add(json.decode(response2.body)["publicUrl"]);
        }
      }
    } else {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFCFAF8),
      child: ListView(
        padding: const EdgeInsets.all(4),
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllItems(title: widget.title)),
                );
              },
              child: const Text(
                '전체보기',
                style: TextStyle(
                  color: Colors.blue, // 텍스트 색상 설정
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildChildren(context)
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

    List<Widget> _buildChildren(BuildContext context) {
      List<Widget> children = [];

      if (widget.title == 'RECENT') {
        children.addAll(items.map((item) {
          return _buildCard(item, 'RECENT');
        }).toList());
      } else if (widget.title == 'POPULAR') {
        children.addAll(columns.map((item) {
          return _buildCard(item, 'POPULAR');
        }).toList());
      } else if (widget.title == 'DAILY') {
        children.addAll(daily.map((item) {
          return _buildCard(item, 'DAILY');
        }).toList());
      } else {
        children.addAll(items.map((item) {
          return _buildCard(item, 'RECENT');
        }).toList());
      }

    return children;
  }


  Widget _buildCard(CustomItem item, String title) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ItemDetail(
                      assetPath: item.imgPath,
                      cookieprice: item.price,
                      cookiename: item.name)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            item.isFavorite
                                ? Icon(Icons.favorite, color: Colors.red[700])
                                : Icon(Icons.favorite_border,
                                    color: Colors.red[700])
                          ])),
                  Hero(
                      tag: item.imgPath,
                      child:  Image.asset(
                              item.imgPath,
                              height: 95,
                              width: 150,
                              fit: BoxFit.contain,
                            )),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      color: const Color(0xFFEBEBEB),
                      height: 1.0),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(item.price,
                            style: TextStyle(
                                color: Colors.red[700], fontSize: 14.0)),
                        SizedBox(width: 10.0), // 여기에 원하는 크기의 공간을 추가합니다.
                        Text(item.name,
                            style: TextStyle(
                                color: Color(0xFF575E67), fontSize: 14.0)),
                      ]),
                  SizedBox(height: 5.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    RatingBarIndicator(
                      rating: 3.5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                    ),
                    Text('3.5점 (500명)'),
                  ]),
                  Text('정가 ${item.price}',
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                ]))));
  }
}

class CustomItem {
  final String name;
  final String price;
  final String imgPath;
  bool isFavorite;

  CustomItem({
    required this.name,
    required this.price,
    required this.imgPath,
    this.isFavorite = false,
  });
}
