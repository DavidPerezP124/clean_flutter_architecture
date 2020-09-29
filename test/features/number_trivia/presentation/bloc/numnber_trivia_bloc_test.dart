import 'package:clean_architecture_flutter_beguinner/core/error/failures.dart';
import 'package:clean_architecture_flutter_beguinner/core/presentation/util/input_converter.dart';
import 'package:clean_architecture_flutter_beguinner/core/usecases/usecase.dart'
    show NoParams;
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        inputConverter: mockInputConverter,
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia);
  });

  test(
    'should return empty on initial state',
    () async {
      // arrange
      final state = bloc.initialState;
      // assert
      expect(state, equals(TypeMatcher<Empty>()));
    },
  );
  group('getTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
    void _setupMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    void _setupGetConcreteNumberTriviaSuccess() {
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
    }

    void _setupGetConcreteNumberTriviaFails() {
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
    }

    void _setupGetConcreteNumberTriviaCacheFails() {
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
    }

    void _dispatchFromBloc() {
      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    }

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        _setupMockInputConverterSuccess();
        // act
        _dispatchFromBloc();
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );
    test(
      'should emit an Error when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));

        // assert
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );

    test(
      'should get data for concrete usecase',
      () async {
        // arrange
        _setupMockInputConverterSuccess();
        _setupGetConcreteNumberTriviaSuccess();
        // act
        _dispatchFromBloc();
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is received succesfully',
      () async {
        // arrange
        _setupMockInputConverterSuccess();
        _setupGetConcreteNumberTriviaSuccess();
        // assert later
        final expected = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        _setupMockInputConverterSuccess();
        _setupGetConcreteNumberTriviaFails();
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );

    test(
      'should emit [Loading, Error] with proper message for the error when getting data fails',
      () async {
        // arrange
        _setupMockInputConverterSuccess();
        _setupGetConcreteNumberTriviaCacheFails();
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );
  });
  group('getTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void _setupGetRandomNumberTriviaSuccess() {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
    }

    void _setupGetRandomNumberTriviaFails() {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
    }

    void _setupGetRandomNumberTriviaCacheFails() {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
    }

    void _dispatchFromBloc() {
      bloc.dispatch(GetTriviaForRandomNumber());
    }

    test(
      'should get data for concrete usecase',
      () async {
        // arrange
        _setupGetRandomNumberTriviaSuccess();
        // act
        _dispatchFromBloc();
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is received succesfully',
      () async {
        // arrange
        _setupGetRandomNumberTriviaSuccess();
        // assert later
        final expected = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        _setupGetRandomNumberTriviaFails();
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );

    test(
      'should emit [Loading, Error] with proper message for the error when getting data fails',
      () async {
        // arrange
        _setupGetRandomNumberTriviaCacheFails();
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        _dispatchFromBloc();
      },
    );
  });
}
