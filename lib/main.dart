import 'package:flutter/material.dart';
import 'ui/screens/cocktail_detail_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    home: Material(
        child: CocktailDetailPage('11007')),
  ));
}
