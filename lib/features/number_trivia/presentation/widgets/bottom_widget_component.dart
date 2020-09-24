import 'package:flutter/material.dart';

Widget bottomWidget() {
  final _height = 10.0;
  final _children = [
    Placeholder(
      fallbackHeight: 40,
    ),
    SizedBox(
      height: _height,
    ),
    Row(
      children: [
        Placeholder(
          fallbackHeight: 30,
        ),
        Placeholder(
          fallbackHeight: 30,
        ),
      ]
          //  wrap children in expanded
          .map((e) => Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: e,
              )))
          .toList(),
    )
  ];
  return Column(
    children: _children,
  );
}
