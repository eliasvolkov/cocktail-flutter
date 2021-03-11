import 'dart:io';

import '../dto/ingredient_dto.dart';

import '../dto/cocktail_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models.dart';

class AsyncCocktailRepository {
  Future<Cocktail> fetchCocktailDetails(String id) async {
    Cocktail result;

    var client = http.Client();
    try {
      final url =
          'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));
        if (dtos.length > 0) {
          result = _createCocktailFromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Ingredient> lookupIngredientById(String id) async {
    Ingredient result;

    var client = http.Client();
    try {
      String url =
          "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=$id";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var ingredients = jsonResponse['ingredients'];
        final dto = IngredientDto.fromJson(ingredients[0]);
        result = _createIngredientFromDto(dto);
      }else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
    return result;
  }

  Cocktail _createCocktailFromDto(CocktailDto dto) {
    final glass = GlassType.parse(dto.strGlass);
    final cocktailType = CocktailType.parse(dto.strAlcoholic);
    final category = CocktailCategory.parse(dto.strCategory);

    var ingredients = <IngredientDefinition>[];

    _getIngredients(dto).forEach(
        (key, value) => ingredients.add(IngredientDefinition(key, value)));

    return Cocktail(
      id: dto.idDrink,
      category: category,
      cocktailType: cocktailType,
      glassType: glass,
      instruction: dto.strInstructions,
      isFavourite: true,
      name: dto.strDrink,
      ingredients: ingredients,
      drinkThumbUrl: dto.strDrinkThumb,
    );
  }

  Map<String, String> _getIngredients(CocktailDto dto) {
    return <String, String>{
      if (dto.strIngredient1 != null) dto.strIngredient1: dto.strMeasure1,
      if (dto.strIngredient2 != null) dto.strIngredient2: dto.strMeasure2,
      if (dto.strIngredient3 != null) dto.strIngredient3: dto.strMeasure3,
      if (dto.strIngredient4 != null) dto.strIngredient4: dto.strMeasure4,
      if (dto.strIngredient5 != null) dto.strIngredient5: dto.strMeasure5,
      if (dto.strIngredient6 != null) dto.strIngredient6: dto.strMeasure6,
      if (dto.strIngredient7 != null) dto.strIngredient7: dto.strMeasure7,
      if (dto.strIngredient8 != null) dto.strIngredient8: dto.strMeasure8,
      if (dto.strIngredient9 != null) dto.strIngredient9: dto.strMeasure9,
      if (dto.strIngredient10 != null) dto.strIngredient10: dto.strMeasure10,
      if (dto.strIngredient11 != null) dto.strIngredient11: dto.strMeasure11,
      if (dto.strIngredient12 != null) dto.strIngredient12: dto.strMeasure12,
      if (dto.strIngredient13 != null) dto.strIngredient13: dto.strMeasure13,
      if (dto.strIngredient14 != null) dto.strIngredient14: dto.strMeasure14,
      if (dto.strIngredient15 != null) dto.strIngredient15: dto.strMeasure15,
    };
  }

  Ingredient _createIngredientFromDto(IngredientDto dto) {
    return Ingredient(
        id: dto.id,
        name: dto.name,
        description: dto.description,
        ingredientType: dto.ingredientType,
        isAlcoholic: false);
  }
}
