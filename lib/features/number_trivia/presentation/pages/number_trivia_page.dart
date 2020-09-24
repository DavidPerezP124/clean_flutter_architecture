import 'package:clean_architecture_flutter_beguinner/features/number_trivia/presentation/styles/test_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';

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
      _top(),
      _bottom(),
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

  Widget _bottom() {
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
}

class _top extends StatefulWidget {
  const _top({
    Key key,
  }) : super(key: key);

  @override
  __topState createState() => __topState();
}

class __topState extends State<_top> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(
            message: 'Start Searching',
          );
        }
        if (state is Error) {
          return MessageDisplay(
            message: state.message,
          );
        }
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Loaded) {
          return TriviaDisplay(
            number: state.trivia.number.toString(),
            message: state.trivia.text,
          );
        }
        return Placeholder();
      },
    );
  }
}

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

Text biggerText(String text,
    {@required BuildContext context, double fontSize = 25}) {
  return Text(
    text,
    style: TriviaStyles.bigLetterStyle(context, fontSize: fontSize),
    textAlign: TextAlign.center,
  );
}
