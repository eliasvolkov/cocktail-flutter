import 'package:flutter/material.dart';
import 'package:riverpod_app/core/models/models.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

final ValueNotifier<CocktailCategory> _category =
    ValueNotifier(CocktailCategory.values.first);

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xff1a1927),
            Color(0xff0B0B12),
          ])),
      child: Column(
        children: [
          Container(
            height: 40.0,
            color: Color(0xff2c2c2d),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            margin: const EdgeInsets.only(top: 22),
            child: CategoryList(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              margin: const EdgeInsets.only(top: 22),
              child: _buildCocktailList(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCocktailList() {
  return ValueListenableBuilder(
      valueListenable: _category,
      builder: (BuildContext context, CocktailCategory value, Widget child) {
        return FutureBuilder<Iterable<CocktailDefinition>>(
            future: AsyncCocktailRepository()
                .fetchCocktailsByCocktailCategory(_category.value),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                var cocktailItems = snapshot.data;
                var gridItems =
                    cocktailItems.map((item) => _buildGridItem(item)).toList();
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: gridItems,
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Сообщение об ошибке',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xffEAEAEA),
                    ),
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/shaker.png",
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 9),
                      child: const Text(
                        'Поиск...',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xffEAEAEA),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      });
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _activeCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, i) {
            return GestureDetector(
              child: _itemBuilder(
                  CocktailCategory.values.toList()[i], i == _activeCategory),
              onTap: () {
                setState(() {
                  _activeCategory = i;
                  _category.value = CocktailCategory.values.toList()[i];
                });
              },
            );
          },
          separatorBuilder: (context, i) => SizedBox(
                width: 10.0,
              ),
          itemCount: CocktailCategory.values.length),
    );
  }

  Widget _itemBuilder(CocktailCategory item, bool isChosen) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: _getItemDecoration(isChosen),
      child: Text(
        item.value,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  BoxDecoration _getItemDecoration(bool isChosen) {
    if (isChosen) {
      return BoxDecoration(
        color: Color(0xff3B3953),
        border: Border.all(
          color: Color(0xff2D2C39),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      );
    }
    return BoxDecoration(
      color: Color(0xff201F2C),
      border: Border.all(
        color: Color(0xff2D2C39),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(30.0),
    );
  }
}

Widget _buildGridItem(CocktailDefinition cocktail) {
  return Container(
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(cocktail.drinkThumbUrl),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(1.0),
                  Colors.black.withOpacity(0.0),
                ]),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cocktail.name, style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),),
                _cocktailInfoBadge("ID ${cocktail.id}")
              ],
            ),
          ) ,
        ),
        // ClipRRect(
        //     borderRadius: BorderRadius.circular(8.0),
        //     child: Image.network(cocktail.drinkThumbUrl)),
      ],
    ),
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
        fontSize: 10,
        color: Color(0xffEAEAEA),
      ),
    ),
  );
}