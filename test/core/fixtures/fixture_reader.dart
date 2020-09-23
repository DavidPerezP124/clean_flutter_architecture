import 'dart:io';

String fixture(String name) => File(
        'package:clean_architecture_flutter_beguinner/../test/core/fixtures/$name')
    .readAsStringSync();
