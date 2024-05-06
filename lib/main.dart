import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'BottomNavigation.dart';
import 'ItemsList.dart';
import 'ScrollVertical.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

void main() async {
  //📲 runApp을 수행하기전에 비동기 작업을 할 경우 추가해주는 코드입니다
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    //📲 project url을 넣는 부분
   );
  runApp(MyApp());
  uploadImage(File('assets/calmvas.png'));
}
// void main() => runApp(MyApp());

Future<void> uploadImage(File imageFile) async {
  // 파일 이름을 가져오기 위해 path 패키지를 사용할 수 있습니다.
  // 예: final fileName = path.basename(imageFile.path);
  final fileName = imageFile.path.split('/').last;

  final response = await Supabase.instance.client.storage
      .from('massage-image') // 여기서는 스토리지 버킷 이름을 사용합니다.
      .upload('images/$fileName', imageFile); // 파일 경로와 파일 객체를 제공합니다.

  print(response);
}


class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{

  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 3,vsync: this);
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
          icon: Image.asset('assets/calmvas.png'),
          iconSize: 40.0,
          onPressed: () {},
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
        body: ListView(
          children: <Widget>[
            CarouselWidget(),
            Container(
              height: 150,
              color: Colors.white,
              child: ListView(
                // padding: EdgeInsets.only(left: 20),
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text("Categories",style: TextStyle(fontFamily: "Varela",fontSize: 35),),
                  // SizedBox(height: 20,),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    isScrollable: false,
                    labelColor: Colors.red[700],
                    unselectedLabelColor: Color(0xff515c6f),
                    // labelPadding: EdgeInsets.only(right: 45),
                    tabs: <Widget>[
                      Tab(
                        child: Text("최신제품",style: TextStyle(fontFamily: "Varela",fontSize: 21),),
                      ),
                      Tab(
                        child: Text("인기칼럼",style: TextStyle(fontFamily: "Varela",fontSize: 21),),
                      ),
                      Tab(
                        child: Text("데일리 문제",style: TextStyle(fontFamily: "Varela",fontSize: 21),),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 750,
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    ItemsList(title: "RECENT"),
                    ItemsList(title: "POPULAR"),
                    ItemsList(title: "DAILY")
                  ]),
            ),
            
            //CookieItems(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.red[700],//olor(0xFFf17422),
          child: Icon(Icons.add_shopping_cart),
        ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CookingNavigator(),
      ),
    );
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

