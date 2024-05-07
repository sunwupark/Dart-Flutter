import 'package:flutter/material.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.red[700],
      child: const Icon(Icons.add_shopping_cart),
    );
  }
}
