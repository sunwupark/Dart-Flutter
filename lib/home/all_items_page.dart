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
  late String title;
  List<dynamic> products = [];

  _AllItemsListState() {
    products = [];
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    fetchItems(name: title).then((value) {
    setState(() {
      products = value;
    });
  });
  }

  Future<List<dynamic>> fetchItems({name=String}) async {
    // you can replace your api link with this link
    final response = await http.get(Uri.parse('http://localhost:8080/' + name.toString().toLowerCase() + '/search/all'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes))["recents"];
      return jsonData;
    }
    return [];
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
          child: products.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.8,
                  shrinkWrap: true,
                  children: List.generate(
                    products.length,
                    (index) => _buildCard(
                      products[index]['title'],
                      products[index]["price"].toString(),
                      products[index]['image'],
                      products[index]['rating'],
                      products[index]['count'].toString(),
                      index % 2 == 0,
                      index % 4 == 2,
                      context,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
)
      )
    );
  }
}


Widget _buildCard(String name, String price, String imgPath, double rating, String count, bool added,
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
                  child: Image.network(
                    imgPath,
                    height: 95.0,
                    width: 150.0,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 95.0,
                        width: 150.0,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(Icons.error, color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                ),
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
                    rating: rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 10.0,
                    direction: Axis.horizontal,
                  ),
                  Text(rating.toString() + "(점) " + count + "개"),
                ]),
                Text('정가 ${price}',
                  style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 14.0)),
    ]))));
}

