import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/bottom_widget_component.dart';
import '../widgets/top_component.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title Trivia'),
        ),
        body: _buildBody());
  }

  BlocProvider<NumberTriviaBloc> _buildBody() {
    final _children = [
      TopWidget(),
      BottomWidget(),
    ];
    var _flexibleChildren = _children
        .map((e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: e,
              ),
            ))
        .toList();
    return BlocProvider(
      builder: (context) => sl<NumberTriviaBloc>(),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: _flexibleChildren,
        ),
      ),
    );
  }
}
