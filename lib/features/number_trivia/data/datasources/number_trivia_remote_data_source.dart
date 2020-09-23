import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

final String URL_ENDPOINT = 'http://numbersapi.com/';
final Map<String, String> URL_HEADERS = {'Content-Type': 'application/json'};

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    /*  try {
      final response =
          await  */
    client.get(URL_ENDPOINT + '$number', headers: URL_HEADERS);
    /*  return NumberTriviaModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw http.ClientException('Error calling endpoint');
    } */
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return null;
  }
}
