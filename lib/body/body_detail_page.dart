import 'package:calmvas/widgets/appbars.dart';
import 'package:calmvas/widgets/bottom_navigation.dart';
import 'package:calmvas/widgets/floating_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calmvas/body/body_item_Details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BodyDetailPage extends StatefulWidget {
  final String title;

  const BodyDetailPage({super.key, required this.title});

  @override
  State<BodyDetailPage> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetailPage> {
  late String title;
  late List<dynamic> items;
  // const BodyDetailPage({Key? key, required this.title}) : super(key: key);

  _BodyDetailState() {
    items = [];
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    fetchItems(name: title).then((value) {
    setState(() {
      items = value;
    });
  });
  }

  
  Future<List<dynamic>> fetchItems({name = String}) async {
    // you can replace your api link with this link
    final response = await http.get(Uri.parse('http://dungdungcloud.shop:8080/post/search/category/' + name));
    if (response.statusCode == 200) {
      // print(response.body);
      List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes))["posts"];
      return jsonData;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageAppBar(context: context, title: '부위별 마사지'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      // 새로운 페이지로 이동하는 코드 추가
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => bodyItemDetail(
                            imagePath: items[index]["image"],
                            title: items[index]["title"],
                            content: items[index]["content"],
                            category: items[index]["category"],
                            videourl: items[index]["url"]
                            ),
                        ),
        );
      },
      child: listItem(items[index]),
    ),
    separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(height: 20),
    itemCount: items.length,
  ),
),

            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget listItem(dynamic item) {
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          item['image'],
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item['title'],
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
