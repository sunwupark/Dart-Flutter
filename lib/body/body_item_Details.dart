import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class bodyItemDetail extends StatelessWidget {
  final imagePath, videourl, title, content, category;

  bodyItemDetail({this.title, this.content, this.imagePath, this.videourl, this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('stuffs',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('Items',
              style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700])),
        ),
        const SizedBox(height: 15.0),
        Hero(
            tag: imagePath,
            child: Image.network(imagePath,
                height: 150.0, width: 100.0, fit: BoxFit.contain)),
        SizedBox(height: 30.0),
        Center(
          child: Text(title,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              videourl,
              style: const TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        SizedBox(height: 20.0),
        
      ]),

      /*floatingActionButton: FloatingActionButton(onPressed: () {},
      backgroundColor: Color(0xFFF17532),
      child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CookingNavigator(),*/
    );
  }
}
