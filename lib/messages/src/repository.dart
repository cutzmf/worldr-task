import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/messages/src/message.dart';
import 'package:worldrtesttask/persons/src/person.dart';

part 'repository.g.dart';

class MessagesRepository extends HiveStorage<HiveMessage, Message> {
  MessagesRepository(Box<HiveMessage> box) : super(box: box);
}

@HiveType(typeId: 3)
class HiveMessage extends HiveEntity with EquatableMixin implements Message {
  @override
  @HiveField(10)
  final Person from;

  @override
  @HiveField(13)
  final String text;

  HiveMessage({
    @required String id,
    @required this.from,
    @required this.text,
    @required bool isUnread,
  }) : super(id: id, isUnread: isUnread);

  @override
  List<Object> get props => [id, isUnread, from, text];

  @override
  bool get stringify => true;
}
