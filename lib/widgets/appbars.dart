import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Image.asset('assets/calmvas.png'),
      iconSize: 40,
      onPressed: () {},
    ),
    centerTitle: false,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.account_circle),
        iconSize: 30,
        onPressed: () {
          // move to profile
        },
      )
    ],
  );
}

AppBar pageAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 1,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title ?? '',
      style: const TextStyle(fontSize: 20),
    ),
    actions: actions,
  );
}
