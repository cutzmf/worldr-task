import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:worldrtesttask/common/common.dart';

abstract class EntityEvent {}

class MarkRead implements EntityEvent {
  final Entity entity;

  MarkRead(this.entity);
}

class _Update<T> implements EntityEvent {
  List<T> entities;

  _Update(this.entities);
}

class EntityState {}

class Initializing implements EntityState {}

class Loaded<T> implements EntityState {
  final List<T> entities;

  Loaded(this.entities);
}

class EntityBloc<T extends Entity> extends Bloc<EntityEvent, EntityState> {
  final Repository<T> repository;

  @override
  EntityState get initialState => Initializing();

  @override
  Stream<EntityState> mapEventToState(EntityEvent event) async* {
    if (event is MarkRead) {
      repository.markRead([event.entity]);
    } else if (event is _Update<T>) {
      yield Loaded<T>(event.entities);
    }
  }

  StreamSubscription _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  EntityBloc({
    @required this.repository,
  }) {
    _subscription =
        repository.listen().cast<List<T>>().listen((it) => add(_Update<T>(it)));
  }
}
