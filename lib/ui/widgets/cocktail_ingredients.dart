import 'package:flutter/material.dart';
import 'package:riverpod_app/core/models/models.dart';

class CocktailIngredients extends StatelessWidget {
  final Cocktail cocktail;

  CocktailIngredients(this.cocktail);

  @override
  Widget build(BuildContext context) {
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


