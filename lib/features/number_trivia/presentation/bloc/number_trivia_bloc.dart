import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter_beguinner/core/error/failures.dart';
import 'package:clean_architecture_flutter_beguinner/core/presentation/util/input_converter.dart';
import 'package:clean_architecture_flutter_beguinner/core/usecases/usecase.dart'
    show NoParams;
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or a zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final InputConverter inputConverter;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaBloc(
      {@required this.inputConverter,
      @required GetConcreteNumberTrivia concrete,
      @required GetRandomNumberTrivia random})
      : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(_leftHandler, _rightHandler);
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherErrorOrLoadedState(failureOrTrivia);
    }
  }

  Stream<Error> _leftHandler(failure) async* {
    yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
  }

  Stream<NumberTriviaState> _rightHandler(integer) async* {
    yield Loading();
    final failureOrTrivia =
        await getConcreteNumberTrivia(Params(number: integer));
    yield* _eitherErrorOrLoadedState(failureOrTrivia);
  }

  Stream<NumberTriviaState> _eitherErrorOrLoadedState(
      Either<Failure, NumberTrivia> failureOrTrivia) async* {
    yield failureOrTrivia.fold(
        (failure) => Error(message: ''.byFailureType(failure)),
        (trivia) => Loaded(trivia: trivia));
  }
}

extension ByFailureType on String {
  String byFailureType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
