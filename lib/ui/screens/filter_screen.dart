import 'package:flutter/material.dart';
import 'package:riverpod_app/core/models/models.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

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
        ],
      ),
    );
  }
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
