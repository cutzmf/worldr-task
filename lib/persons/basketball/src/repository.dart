import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:worldrtesttask/common/common.dart';

import 'player.dart';

part 'repository.g.dart';

class BasketballPlayerRepository
    extends HiveStorage<HiveBasketballPlayer, BasketballPlayer> {
  BasketballPlayerRepository(Box<HiveBasketballPlayer> box) : super(box: box);
}

@HiveType(typeId: 0)
class HiveBasketballPlayer extends HiveEntity
    with EquatableMixin
    implements BasketballPlayer {
  @override
  @HiveField(10)
  String name;

  @override
  List<Object> get props => [id, name, isUnread];

  @override
  bool get stringify => true;

  HiveBasketballPlayer({
    @required String id,
    @required this.name,
    @required bool isUnread,
  }) : super(id: id, isUnread: isUnread);
}
