import 'dart:ui';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'models/src/model/cocktail.dart';
import 'models/src/model/ingredient_definition.dart';

class CocktailDetailPage extends StatelessWidget {
  CocktailDetailPage(
    this.cocktail, {
    Key? key,
  }) {
    init();
  }

  final Cocktail cocktail;

  void init() async {
    // try {
    //   await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // } catch (error) {
    //   print(error);
    // }
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> instructions = cocktail.instruction.split('\n');
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            FutureBuilder(builder: (context, AsyncSnapshot<dynamic> snapshot) {
              return Text('Loading');
            }),
            _heroWidget(size),
            _cocktailInfo(cocktail),
            _cocktailIngredients(cocktail),
            _cocktailInstruction(instructions),
          ],
        ),
      ),
    );
  }
}

Widget _heroWidget(Size size) {
  return Stack(
    children: [
      Image.asset(
        'assets/coctail.png',
        width: size.width,
        fit: BoxFit.contain,
      ),
      Positioned(
        top: 30,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              Icon(Icons.open_in_browser, color: Colors.white),
            ],
          ),
        ),
      )
    ],
  );
}

Widget _cocktailInfo(Cocktail cocktail) {
  return Container(
    padding: EdgeInsets.only(
      top: 30.0,
      right: 34.0,
      bottom: 18.0,
      left: 34.0,
    ),
    color: Color(0xff1A1927),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              cocktail.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 20,
              ),
            )),
            Icon(
              Icons.favorite,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Id:12864',
            style: TextStyle(fontSize: 13, color: Color(0xff848396)),
          ),
        ),
        _cocktailInfoItem(
            subtitle: 'Категория коктейля', badgeText: cocktail.category.name),
        _cocktailInfoItem(
            subtitle: 'Тип коктейля', badgeText: cocktail.cocktailType.name),
        _cocktailInfoItem(
            subtitle: 'Тип стекла', badgeText: cocktail.glassType.name),
      ],
    ),
  );
}

Widget _cocktailIngredients(Cocktail cocktail) {
  return Container(
    color: Colors.black,
    padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Инградиенты:',
              style: TextStyle(
                color: Color(0xffB1AFC6),
                fontSize: 16,
              ),
            )
          ],
        ),
        ...cocktail.ingredients
            .map((ingredient) => _ingredientItem(ingredient))
            .toList()
      ],
    ),
  );
}

Widget _cocktailInstruction(List<String> instructions) {
  return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 24.0,
        right: 34.0,
        bottom: 40.0,
        left: 34.0,
      ),
      color: Color(0xff1A1927),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Инструкция для приготовления',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          ...instructions
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ));
}

Widget _cocktailInfoItem({String subtitle = '', String badgeText = ''}) {
  return Container(
    margin: EdgeInsets.only(top: 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cocktailInfoSubtitle(subtitle),
        _cocktailInfoBadge(badgeText)
      ],
    ),
  );
}

Widget _cocktailInfoSubtitle(String subtitle) {
  return Text(
    subtitle,
    style: TextStyle(fontSize: 14, color: Color(0xffEAEAEA)),
  );
}

Widget _cocktailInfoBadge(String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
    margin: EdgeInsets.only(top: 8.0),
    decoration: BoxDecoration(
      color: Color(0xff15151C),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Color(0xffEAEAEA),
      ),
    ),
  );
}

Widget _ingredientItem(IngredientDefinition ingredient) {
  return Container(
    margin: EdgeInsets.only(top: 16.0),
    child: Row(
      children: [
        Expanded(
            child: Text(ingredient.ingredientName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ))),
        Text(ingredient.measure,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ))
      ],
    ),
  );
}
