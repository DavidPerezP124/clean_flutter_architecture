import 'package:flutter/material.dart';

import 'text_widget.dart';

class TriviaDisplay extends StatelessWidget {
  final String number;
  final String message;
  const TriviaDisplay({
    Key key,
    @required this.message,
    @required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            biggerText(number, context: context, fontSize: 35),
            biggerText(
              message,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
