import '../../models.dart';

class SyncCocktailRepository {
  // static Iterable<Cocktail> _innerCache;

  Cocktail getHomeworkCocktail() {
    return Cocktail(
      id: '12864',
      category: CocktailCategory.cocktail,
      cocktailType: CocktailType.alcoholic,
      glassType: GlassType.highballGlass,
      instruction: '- В большом бокале смешайте порванные листья мяты,'
          ' разрезанный на кусочки лайм и сахар. '
          'Толкушкой хорошо раздавите, '
          'чтобы лайм пустил сок.'
          '\n'
          '- Добавьте мелко нарезанную кубиками мякоть арбуза и снова слегка растолките.'
          '\n'
          '- Добавьте ром и лед. Перемешайте и разлейте по бокалам. Сразу подавайте.',
      isFavourite: true,
      name: 'Арбузный мохито',
      ingredients: [
        IngredientDefinition('Листья мяты', '4 шт'),
        IngredientDefinition('Лайм', '½ шт'),
        IngredientDefinition('Сахар', '1 ст. ложка'),
        IngredientDefinition('Белый ром', '60 мл'),
        IngredientDefinition('Лед', '½ стакана'),
        IngredientDefinition('Мякоть арбуза', '120 г'),
      ],
      drinkThumbUrl:
      'https://images.unsplash.com/photo-1587223962930-cb7f31384c19?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8Y29ja3RhaWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    );
  }
}