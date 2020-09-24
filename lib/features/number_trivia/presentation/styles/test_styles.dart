import 'package:flutter/material.dart';

class TriviaStyles {
  TriviaStyles._();

  static TextStyle bigLetterStyle(BuildContext context,
      {double fontSize = 25}) {
    return Theme.of(context).textTheme.headline6.copyWith(
          color: Colors.grey,
          fontSize: fontSize,
        );
  }
}
