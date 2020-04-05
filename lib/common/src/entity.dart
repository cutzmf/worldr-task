abstract class Entity implements Readable {
  String get id;
}

abstract class Readable {
  bool get isUnread;
}
