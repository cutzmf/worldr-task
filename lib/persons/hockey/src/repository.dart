import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:worldrtesttask/common/common.dart';

import 'player.dart';

part 'repository.g.dart';

class HockeyPlayerRepository
    extends HiveStorage<HiveHockeyPlayer, HockeyPlayer> {
  HockeyPlayerRepository(Box<HiveHockeyPlayer> box) : super(box: box);
}

@HiveType(typeId: 1)
class HiveHockeyPlayer extends HiveEntity
    with EquatableMixin
    implements HockeyPlayer {
  @override
  @HiveField(10)
  String name;

  @override
  @HiveField(11)
  bool alignRight;

  @override
  List<Object> get props => [id, isUnread, name, alignRight];

  @override
  bool get stringify => true;

  HiveHockeyPlayer({
    @required String id,
    @required this.alignRight,
    @required this.name,
    @required bool isUnread,
  }) : super(id: id, isUnread: isUnread);
}
