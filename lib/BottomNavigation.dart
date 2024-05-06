import 'package:flutter/material.dart';

class CookingNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 60.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)
                ),
                color: Colors.white
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 20.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.alarm, color: Colors.red[700]),
                          Icon(Icons.person_outline, color: Color(0xFF676E79)),


                        ],
                      )
                  ),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 20.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/cart');
                            },
                            color: Color(0xFF676E79),

                            ),
                          Icon(Icons.shopping_basket, color: Color(0xFF676E79))
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}
