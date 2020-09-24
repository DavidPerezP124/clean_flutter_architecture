import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'message_display_component.dart';
import 'trivia_display_component.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({
    Key key,
  }) : super(key: key);

  @override
  TopWidgetState createState() => TopWidgetState();
}

class TopWidgetState extends State<TopWidget> {
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
