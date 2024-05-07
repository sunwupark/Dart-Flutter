import 'package:flutter/material.dart';
import '../ItemDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllItems extends StatefulWidget {
  final String title;

  const AllItems({super.key, required this.title});

  @override
  State<AllItems> createState() => _AllItemsListState();
}

class _AllItemsListState extends State<AllItems> {
  List<String> products = [];

  @override
  void initState() {
    super.initState();
    String title = widget.title;
    print("dfjiadjfoidshfasjfds" + widget.title);
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
          print("dfjiadjfoidshfasjfds" + widget.title);
          products.add(json.decode(response2.body)["publicUrl"]);
        }
      }
    } else {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: new Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 40.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30,
              onPressed: (){},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.8,
            shrinkWrap: true,
            children: List.generate(
              8, // 8개의 카드를 생성
              (index) => _buildCard(
                ['Black', 'Red-Black', 'Jungle classic', 'Black-Gray'][index % 4],
                '\$129.99',
                ['assets/black.png', 'assets/red-black.png', 'assets/jungle.png', 'assets/black-gray.png'][index % 4],
                index % 2 == 0,
                index % 4 == 2,
                context,
              ),
            ),
  ),
)

      )
    );
  }
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

