import 'package:calmvas/body/body_page.dart';
import 'package:calmvas/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() async {
  //📲 runApp을 수행하기전에 비동기 작업을 할 경우 추가해주는 코드입니다
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   //📲 project url을 넣는 부분
  //  );
  runApp(MyApp());
  // uploadImage(File('assets/calmvas.png'));
}
// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home', // home
        routes: {
          '/home': (context) => HomePage(),
          '/body': (context) => BodyPage(),
        },
        theme: ThemeData(fontFamily: 'Varela'),
        home: HomePage());
  }
}

class CookiesMasters extends StatefulWidget {
  @override
  _CookiesMastersState createState() => _CookiesMastersState();
}

class _CookiesMastersState extends State<CookiesMasters> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
    );
  }
}