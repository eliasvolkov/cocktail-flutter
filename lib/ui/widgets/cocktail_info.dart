import 'package:flutter/material.dart';
import 'package:riverpod_app/core/models/models.dart';

class CocktailInfo extends StatelessWidget {
  final Cocktail cocktail;

  CocktailInfo(this.cocktail);

  @override
  Widget build(BuildContext context) {
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
              subtitle: 'Категория коктейля',
              badgeText: cocktail.category.name),
          _cocktailInfoItem(
              subtitle: 'Тип коктейля', badgeText: cocktail.cocktailType.name),
          _cocktailInfoItem(
              subtitle: 'Тип стекла', badgeText: cocktail.glassType.name),
        ],
      ),
    );
  }
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
