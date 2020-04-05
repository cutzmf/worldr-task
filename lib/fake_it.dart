import 'dart:math';

import 'package:better_uuid/uuid.dart';
import 'package:faker/faker.dart' hide Person;
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:worldrtesttask/messages/messages.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';
import 'package:worldrtesttask/persons/persons.dart';

const _basketball = 1;
const _hockey = 2;
const _message = 3;

class TestTaskFaker {
  final _faker = Faker();
  final _random = Random();
  final Box<HiveBasketballPlayer> basketballBox;
  final Box<HiveHockeyPlayer> hockeyBox;
  final Box<HiveMessage> messageBox;

  Future<void> _prepopulate() async {
    // persons
    for (var i = 0; i < _random.nextInt(3) + 3; i++) {
      await _createFakeEntity(_random.nextBool() ? _basketball : _hockey);
    }

    //messages
    for (var i = 0; i < _random.nextInt(6) + 5; i++) {
      await _createFakeEntity(_message);
    }
  }

  Stream<void> _appLifetimeStream() async* {
    await _prepopulate();

    while (true) {
      final int delay = _random.nextInt(5) + 1;
      await Future.delayed(Duration(seconds: delay));
      yield _createFakeEntity(_random.nextInt(3) + 1);
    }
  }

  Future<void> _createFakeEntity(int entityType) async {
    final id = Uuid.v1().toString();

    switch (entityType) {
      case _basketball:
        await basketballBox.put(
          id,
          HiveBasketballPlayer(
            id: id,
            name: _faker.person.name(),
            isUnread: true,
          ),
        );
        break;

      case _hockey:
        await hockeyBox.put(
          id,
          HiveHockeyPlayer(
            id: id,
            name: _faker.person.name(),
            alignRight: _random.nextBool(),
            isUnread: true,
          ),
        );
        break;

      case _message:
        final basketOrHockey = _random.nextBool();
        final Box<Person> box = basketOrHockey
            ? (basketballBox.isNotEmpty ? basketballBox : hockeyBox)
            : (hockeyBox.isNotEmpty ? hockeyBox : basketballBox);
        final index = box.length > 1 ? _random.nextInt(box.length) : 0;
        await messageBox.put(
            id,
            HiveMessage(
              id: id,
              from: box.getAt(index),
              text: _faker.lorem.words(_random.nextInt(15) + 3).join(' '),
              isUnread: true,
            ));
        break;
    }
  }

  TestTaskFaker({
    @required this.basketballBox,
    @required this.hockeyBox,
    @required this.messageBox,
  }) {
    _appLifetimeStream().listen((_) {});
  }
}
