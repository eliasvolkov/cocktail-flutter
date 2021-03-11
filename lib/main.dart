import 'package:flutter/material.dart';
import 'package:riverpod_app/models/models.dart';

import 'cocktail_detail_page.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  final cocktail = SyncCocktailRepository().getHomeworkCocktail();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    home: Material(
        child: CocktailDetailPage('11007')),
  ));
}
