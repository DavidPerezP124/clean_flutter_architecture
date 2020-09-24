import 'package:flutter/material.dart';

import '../styles/test_styles.dart';

Text biggerText(String text,
    {@required BuildContext context, double fontSize = 25}) {
  return Text(
    text,
    style: TriviaStyles.bigLetterStyle(context, fontSize: fontSize),
    textAlign: TextAlign.center,
  );
}
