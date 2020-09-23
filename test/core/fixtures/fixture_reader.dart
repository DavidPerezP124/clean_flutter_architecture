import 'dart:io';

String fixture(String name) => File(
        "${Directory.current.absolute.toString().replaceAll('\\', '/').replaceAll('\'', '')}/test/core/fixtures/$name")
    .readAsStringSync();
