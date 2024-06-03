import 'package:calmvas/home/all_items_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ItemDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:calmvas/ColumnDetails.dart';

class ItemsList extends StatefulWidget {
  final String title;

  const ItemsList({super.key, required this.title});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  List<String> products = [];
  List<CustomItem> items = [
    CustomItem(name: '스킨케어 크림', price: '\$12.3', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/item3.jpeg?t=2024-06-01T18%3A24%3A26.826Z'),
    CustomItem(name: '마사지 크림', price: '\$10.99', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/item4.jpeg'),
  ];
  List<CustomItem> columns = [
    CustomItem(name: '효과적인 ‘림프 마사지’ 방법', price: '', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/limpmas.jpeg'),
    CustomItem(name: '[김태권의 건강칼럼3]', price: '', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/footmas.jpeg'),
  ];
  List<CustomItem> daily = [
    CustomItem(name: '오늘의 문제!', price: '', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/questionmark.png?t=2024-06-02T03%3A36%3A10.430Z'),
    CustomItem(name: '답은???', price: '', imgPath: 'https://rmwiqrerffapmjylrcir.supabase.co/storage/v1/object/public/items_image/why.png?t=2024-06-02T03%3A36%3A02.953Z'),
  ];

  @override
  void initState() {
    super.initState();
    String title = widget.title;
    // fetchItems();
    setState(() {
      products;
    });
  }

  // Future<void> fetchItems({name = String}) async {
  //   // you can replace your api link with this link
  //   final response = await http.get(Uri.parse('http://localhost:3000/' + name));
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = json.decode(response.body);
      
  //   }
    
  // }

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
              if(title == 'RECENT'){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    ItemDetail(
                        assetPath: item.imgPath,
                        cookieprice: item.price,
                        cookiename: item.name
                    )
                  ));
              }
              else if(title == "POPULAR"){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    TextInputPage(
                        assetPath: item.imgPath,
                        cookiePrice: item.price,
                        cookieName: item.name,
                        quiz: false
                    )
                  ));
              }
              else if(title == "DAILY" && item.name == '오늘의 문제!'){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    TextInputPage(
                        assetPath: item.imgPath,
                        cookiePrice: item.price,
                        cookieName: item.name,
                        quiz: true,
                    )
                  ));
              }
              else if(title == "DAILY" && item.name == '답은???'){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    TextInputPage(
                        assetPath: item.imgPath,
                        cookiePrice: item.price,
                        cookieName: item.name,
                        quiz: false
                    )
                  ));
              }
              else{
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    ItemDetail(
                        assetPath: item.imgPath,
                        cookieprice: item.price,
                        cookiename: item.name
                    )
                  ));
              }
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
                      child:  Image.network(
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
                  buildItemWidget(item, title)
                ]))));
  }
}

Widget buildItemWidget(CustomItem item, String type) {
  if (type == 'RECENT') {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              item.price,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              item.name,
              style: TextStyle(
                color: Color(0xFF575E67),
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
      ],
    );
  } else if (type == 'POPULAR') {
    // "POPULAR"에 따른 다른 형태의 위젯을 반환
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              item.name,
              style: TextStyle(
                color: Color(0xFF575E67),
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('조회수: 500명'),
          ],
        ),
      ],
    );
  } else {
    // 기본 타입 또는 알 수 없는 타입의 경우 반환
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              item.name,
              style: TextStyle(
                color: Color(0xFF575E67),
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('답변수: 1000명'),
          ],
        ),
      ],
    );
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
