import 'package:flutter/material.dart';

import 'text_widget.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: biggerText(
          message,
          context: context,
        ),
      ),
    );
  }
}
