import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter_beguinner/core/presentation/util/input_converter.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final InputConverter inputConverter;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaBloc(
      {this.inputConverter,
      this.getConcreteNumberTrivia,
      this.getRandomNumberTrivia});

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
