import 'package:json_annotation/json_annotation.dart';
part 'ingredient_dto.g.dart';

@JsonSerializable(createFactory: true, createToJson: false)
class IngredientDto {
  @JsonKey(name: 'idIngredient')
  String id;
  @JsonKey(name: 'strIngredient')
  String name;
  @JsonKey(name: 'strDescription')
  String description;
  @JsonKey(name: 'strType')
  String ingredientType;
  @JsonKey(name: 'strAlcohol')
  String isAlcoholic;

  IngredientDto(
      {this.id,
      this.name,
      this.description,
      this.ingredientType,
      this.isAlcoholic});

  factory IngredientDto.fromJson(Map<String, dynamic> json)=> _$IngredientDtoFromJson(json);
}
