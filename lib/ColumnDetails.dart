import 'dart:ffi';

import 'package:flutter/material.dart';
import 'widgets/bottom_navigation.dart';

class TextInputPage extends StatefulWidget {
  final String assetPath;
  final String cookiePrice;
  final String cookieName;
  final bool quiz;

  TextInputPage({
    required this.assetPath,
    required this.cookiePrice,
    required this.cookieName,
    required this.quiz
  });

  @override
  _TextInputPageState createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  final _textEditingController = TextEditingController();
  String _resultText = '';

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
        title: Text('Column Details',
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
        const SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image.network(widget.assetPath,
                height: 150.0, width: 100.0, fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text(widget.cookiePrice.toString(),
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700])),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.cookieName,
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
                '마사지의 기원이 되는 용어는 무엇일까요? (힌트: 손으로 다룬다라는 아라비아어에서 유래되었다고 합니다.)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        Center(child: widget.quiz 
        ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: '입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      String inputText = _textEditingController.text;
                      if (inputText == "massa") {
                        setState(() {
                          _resultText = '정답입니다.';
                        });
                      } else {
                        setState(() {
                          _resultText = '오답입니다.';
                        });
                      }
                    },
                    child: Text('제출'),
                  ),
                  SizedBox(height: 16.0),
                  if (_resultText.isNotEmpty)
                    Text(
                      _resultText,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: _resultText == '정답입니다.' ? Colors.green : Colors.red,
                      ),
                    ),
                ],
              )
            : Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 300.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                child: Center(
                  child: Text(
                    "*마사지의 기원* \n마사지라는 용어는 아라비아어인 'massa'에서 유래했으며, 그 뜻은 '손으로 다룬다'는 의미입니다. \n마사지의 기원과 역사는 주로 고대 동양의 중국, 인도와 이집트, 아시리아, 그리스, 이탈리아 등에서 찾아볼 수 있습니다. \n중국의 경우 마사지가 오래전부터 전통 의학의 일부로 발전해왔으며, 인도에서는 아유르베다 의학의 일부로 마사지가 행해졌습니다. \n이집트와 아시리아에서도 마사지가 의학적 목적으로 사용되었다는 기록이 있습니다. \n그리스와 이탈리아에서도 마사지가 운동 선수들의 회복을 위해 사용되었으며, 19세기 이후 유럽과 미국에서 대중화되었습니다.",
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
        )
        

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
