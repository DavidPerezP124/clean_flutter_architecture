import 'dart:io';

String fixture(String name) => File(
        // change before pushing to github
        '/home/runner/work/clean_flutter_architecture/clean_flutter_architecture/test/core/fixtures/$name')
    //  'test/core/fixtures/$name')
    // keep this line
    .readAsStringSync();
