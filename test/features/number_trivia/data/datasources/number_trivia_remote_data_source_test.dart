import 'dart:convert';

import 'package:clean_architecture_flutter_beguinner/core/error/exceptions.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void _setupMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void _setupMockHttpClientFails() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 400));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTrivia =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''
should perform a GET request on a URL with number beign 
the EndPoint and with application/json being the header''',
      () async {
        // arrange
        _setupMockHttpClientSuccess200();

        // act
        await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(URL_ENDPOINT + '$tNumber',
            headers: URL_HEADERS));
      },
    );

    test(
      'should return NumberTrivia when the status code is 200',
      () async {
        // arrange
        _setupMockHttpClientSuccess200();

        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, tNumberTrivia);
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        _setupMockHttpClientFails();
        // act
        final call = dataSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
  group('getRandomNumberTrivia', () {
    final tNumberTrivia =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''
should perform a GET request on a URL with number beign 
the EndPoint and with application/json being the header''',
      () async {
        // arrange
        _setupMockHttpClientSuccess200();

        // act
        await dataSource.getRandomNumberTrivia();
        // assert
        verify(
            mockHttpClient.get(URL_ENDPOINT + 'random', headers: URL_HEADERS));
      },
    );

    test(
      'should return NumberTrivia when the status code is 200',
      () async {
        // arrange
        _setupMockHttpClientSuccess200();

        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, tNumberTrivia);
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        _setupMockHttpClientFails();
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
