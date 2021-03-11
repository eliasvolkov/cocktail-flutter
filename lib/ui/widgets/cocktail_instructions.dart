import 'package:flutter/material.dart';

class CocktailInstructions extends StatelessWidget {
  final List<String> instructions;

  CocktailInstructions(this.instructions);

  @override
  Widget build(BuildContext context) {
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
}
