import 'package:clean_architecture_flutter_beguinner/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di show init;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: _kThemeData(context),
      home: NumberTriviaPage(),
    );
  }
}

ThemeData _kThemeData(BuildContext context) => Theme.of(context).copyWith(
      primaryColor: Colors.blueGrey,
      accentColor: Colors.blueAccent,
    );
