import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'models/models.dart';
import 'models/src/model/cocktail.dart';
import 'models/src/model/ingredient_definition.dart';

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
                      width: size.width, fit: BoxFit.cover, height: size.height * 0.3,),

                  // _heroWidget(size),
                  _cocktailInfo(newCocktail),
                  _cocktailIngredients(newCocktail),
                  _cocktailInstruction(instructions),
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
                  if(index == ids.length - 1){
                    index = 0;
                  }else{
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

Widget _heroWidget(Size size) {
  return Image.asset(
    'assets/coctail.png',
    width: size.width,
    fit: BoxFit.contain,
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
            'Id:${cocktail.id}',
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
  if (ingredient == null) {
    return null;
  }
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
        Text(ingredient.measure ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ))
      ],
    ),
  );
}
