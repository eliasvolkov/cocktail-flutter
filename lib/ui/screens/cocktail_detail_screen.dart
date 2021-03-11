import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:riverpod_app/core/models/models.dart';
import 'package:riverpod_app/ui/widgets/cocktail_info.dart';
import 'package:riverpod_app/ui/widgets/cocktail_ingredients.dart';
import 'package:riverpod_app/ui/widgets/cocktail_instructions.dart';

class CocktailDetailPage extends StatefulWidget {
  CocktailDetailPage(this.id);

  final String id;

  @override
  _CocktailDetailPageState createState() => _CocktailDetailPageState();
}

class _CocktailDetailPageState extends State<CocktailDetailPage> {
  Cocktail newCocktail;
  final List<String> ids = ['11007', '11008', '11009'];
  int index = 0;

  void init(index) async {
    try {
      final cocktail =
          await AsyncCocktailRepository().fetchCocktailDetails(ids[index]);
      setState(() {
        newCocktail = cocktail;
      });

      await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      // await
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    init(index);
    print(newCocktail);
  }

  @override
  Widget build(BuildContext context) {
    if (newCocktail != null) {
      final size = MediaQuery.of(context).size;
      final List<String> instructions = newCocktail.instruction.split('\n');
      return Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Image.network(newCocktail.drinkThumbUrl,
                      width: size.width, fit: BoxFit.cover),

                  // _heroWidget(size),
                  CocktailInfo(newCocktail),
                  CocktailIngredients(newCocktail),
                  CocktailInstructions(instructions),
                ],
              ),
            ),
          ),
          _header(size),
        ],
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Positioned _header(Size size) {
    return Positioned(
      top: 30,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (index == ids.length - 1) {
                    index = 0;
                  } else {
                    index += 1;
                  }
                });
                init(index);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Icon(Icons.open_in_browser, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
