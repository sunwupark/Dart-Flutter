import 'package:calmvas/AllItems.dart';
import 'package:flutter/material.dart';
import 'ItemDetails.dart';
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

  @override
  void initState() {
    super.initState();
    String title = widget.title;
    fetchItems();
    setState(() {products;});
  }

  Future<void> fetchItems({name=String}) async {
    // you can replace your api link with this link
    final response = await http.get(Uri.parse('http://localhost:3000/' + name));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        var response2 = await http.get(Uri.parse('http://localhost:3000/${name}/${jsonData[i]}'));
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
  return Scaffold(
    backgroundColor: Color(0xFFFCFAF8),
    body: ListView(
      children: <Widget>[
        // SizedBox(height: 15.0),
        Container(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllItems(title: widget.title)),
              );
            },
            child: Text(
              '전체보기',
              style: TextStyle(
                color: Colors.blue, // 텍스트 색상 설정
              ),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              shrinkWrap: true, // GridView가 자신의 컨텐츠 크기에 맞춰지도록 설정
              physics: NeverScrollableScrollPhysics(), // GridView 내부 스크롤 비활성화
              children: <Widget>[
                _buildCard('Item3', '\$12.3', 'assets/item3.jpeg',
                    false, false, context),
                _buildCard('Item4', '\$10.99', 'assets/item4.jpeg',
                    true, false, context),
                // _buildCard('Jungle classic', '\$129.99',
                //     'assets/jungle.png', false, true, context),
                // _buildCard('Black-Gray', '\$129.99', 'assets/black-gray.png',
                //     false, false, context)
              ],
            )),
        SizedBox(height: 15.0)
      ],
    ),
  );
}


  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ItemDetail(
                      assetPath: imgPath,
                      cookieprice:price,
                      cookiename: name
                  )));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: Colors.red[700])
                                : Icon(Icons.favorite_border,
                                color: Colors.red[700])
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 95.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                 
                  SizedBox(height: 5.0),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text(price,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                    SizedBox(width: 10.0), // 여기에 원하는 크기의 공간을 추가합니다.
                    Text(name,
                      style: TextStyle(
                        color: Color(0xFF575E67),
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                  ]),
                  SizedBox(height: 5.0),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
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
                  ]),
                  Text('정가 ${price}',
                    style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 14.0)),



                ]))));
  }
}
