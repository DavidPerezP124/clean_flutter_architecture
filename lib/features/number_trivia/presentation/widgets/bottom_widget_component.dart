import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomWidget extends StatefulWidget {
  BottomWidget({Key key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  String inputString;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomWidget(),
    );
  }

  Widget _bottomWidget() {
    final _height = 10.0;
    final _children = [
      TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Search For Number',
        ),
        keyboardType: TextInputType.number,
        onSubmitted: (val) => _dispatchConcrete(),
        onChanged: (val) {
          setState(() {
            inputString = val;
          });
        },
      ),
      SizedBox(
        height: _height,
      ),
      Row(
        children: [
          RaisedButton(
            onPressed: _dispatchConcrete,
            child: Text('Search'),
            color: Theme.of(context).accentColor,
          ),
          RaisedButton(
            onPressed: _dispatchRandom,
            child: Text('Random'),
            color: Theme.of(context).primaryColor,
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

  _dispatchConcrete() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputString));
  }

  _dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumber());
  }
}
