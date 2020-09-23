import 'dart:io';

String fixture(String name) => File(
    //   '/home/runner/work/clean_flutter_architecture/clean_flutter_architecture/test/core/fixtures/$name')
    'test/core/fixtures/$name').readAsStringSync();
