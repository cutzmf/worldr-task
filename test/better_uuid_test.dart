import 'package:better_uuid/uuid.dart';
import 'package:flutter_test/flutter_test.dart';

/// this tests are just to be sure it works like I perceive docs
void main() {
  test('uuid v1 sorted by time from oldest to newest', () {
    /// given
    final uuid0 = Uuid.v1();
    final uuid1 = Uuid.v1();
    final uuid2 = Uuid.v1();
    final list = [uuid1, uuid2, uuid0];

    /// when
    list.sort((u1, u2) => u1.time.compareTo(u2.time));

    /// then
    assert(list[0] == uuid0);
    assert(list[1] == uuid1);
    assert(list[2] == uuid2);
  });

  test('uuid parsed from string', () {
    /// given
    final Uuid original = Uuid.v1();

    /// when
    final Uuid parsedFromString = Uuid(original.toString());

    /// then
    assert(original == parsedFromString);
  });
}
