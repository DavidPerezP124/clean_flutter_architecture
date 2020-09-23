import 'dart:convert';

import 'package:clean_architecture_flutter_beguinner/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_flutter_beguinner/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTrivia = NumberTriviaModel(text: 'Text Test', number: 1);
    test(
      '''
should perform a GET request on a URL with number beign 
the EndPoint and with application/json being the header''',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response(fixture('trivia.json'), 200));

        // act
        await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(URL_ENDPOINT + '$tNumber',
            headers: URL_HEADERS));
      },
    );
  });
}
