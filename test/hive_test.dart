import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/messages/src/repository.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';

void main() {
  Box<HiveBasketballPlayer> basketballBox;
  Box<HiveHockeyPlayer> hockeyBox;
  Box<HiveMessage> messagesBox;
  Repository<BasketballPlayer> basketRepo;
  Repository<HockeyPlayer> hockeyRepo;

  final basketballPlayer = HiveBasketballPlayer(
    id: 'id1',
    name: 'name',
    isUnread: true,
  );
  final hockeyPlayer = HiveHockeyPlayer(
    id: 'id2',
    name: 'name',
    alignRight: true,
    isUnread: true,
  );
  final message = HiveMessage(
      id: 'm1',
      from: basketballPlayer,
      text: 'hi!',
      isUnread: true);

  setUpAll(() async {
    Hive.init('./');
    Hive
      ..registerAdapter(HiveBasketballPlayerAdapter())
      ..registerAdapter(HiveMessageAdapter())
      ..registerAdapter(HiveHockeyPlayerAdapter());

    basketballBox = await Hive.openBox('box1');
    messagesBox = await Hive.openBox('box2');
    hockeyBox = await Hive.openBox('box3');

    basketRepo =
        HiveStorage<HiveBasketballPlayer, BasketballPlayer>(box: basketballBox);
    hockeyRepo = HiveStorage<HiveHockeyPlayer, HockeyPlayer>(box: hockeyBox);

    await basketballBox.put(basketballPlayer.id, basketballPlayer);
    await hockeyBox.put(hockeyPlayer.id, hockeyPlayer);
    await messagesBox.put(message.id, message);
  });

  tearDownAll(() {
    Hive.deleteFromDisk();
  });

  group('hive storage tests', () {
    test('repo marks read', () async {
      final playerMarkedRead = HiveBasketballPlayer(
        id: basketballPlayer.id,
        name: basketballPlayer.name,
        isUnread: false,
      );
      await basketRepo.markRead([basketballPlayer]);
      expect(basketballBox.get(basketballPlayer.id), equals(playerMarkedRead));
    });

    test('listener get updates when items changed', () async {
      expect(hockeyRepo.listen(), emits([isA<HockeyPlayer>()]));
      await hockeyRepo.markRead([hockeyPlayer]);
    });
  });
}
