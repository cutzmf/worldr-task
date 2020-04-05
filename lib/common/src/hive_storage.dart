import 'package:better_uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldrtesttask/common/src/entity.dart';
import 'package:worldrtesttask/common/src/repository.dart';

class HiveStorage<StoredType extends HiveEntity, DomainType extends Entity>
    implements Repository<DomainType> {
  final Box<StoredType> box;

  List<DomainType> get _entitiesSortedByTimestamp {
    final list = box.values.cast<DomainType>().toList();
    list.sort(
      (entity1, entity2) =>
          Uuid(entity1.id).time.compareTo(Uuid(entity2.id).time),
    );
    return list.toList();
  }

  Stream<List<DomainType>> listen() => box
      .watch()
      .map((_) => _entitiesSortedByTimestamp)
      .startWith(_entitiesSortedByTimestamp);

  Future<void> markRead(List<DomainType> entities) async {
    await Future.wait([
      for (var entity in entities) (box.get(entity.id)..isUnread = false).save()
    ]);
  }

  const HiveStorage({
    @required this.box,
  });
}

abstract class HiveEntity extends HiveObject implements Entity {
  @override
  @HiveField(0)
  String id;

  @override
  @HiveField(1)
  bool isUnread;

  HiveEntity({
    @required this.id,
    @required this.isUnread,
  });
}
