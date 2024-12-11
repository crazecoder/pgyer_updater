import 'package:flutter_test/flutter_test.dart';

import 'package:pgyer_updater/src/pgyer_updater.dart';

void main() {
  test('adds one to input values', () {
    expect(PgyerUpdater.check(apiKey: "2",appKey: "",versionName: "1.0.0"), 3);
  });
}
