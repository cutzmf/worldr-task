import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/messages/messages.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';

abstract class HomeEvent {}

class _EntityUpdate implements HomeEvent {
  final List<Readable> entities;

  _EntityUpdate(this.entities);
}

class HomeState with EquatableMixin {
  final String basketballUnread;
  final String hockeyUnread;
  final String messagesUnread;

  bool get hasBasketballUnread => basketballUnread.isNotEmpty;

  bool get hasHockeyUnread => hockeyUnread.isNotEmpty;

  bool get hasMessagesUnread => messagesUnread.isNotEmpty;

  @override
  List<Object> get props => [basketballUnread, hockeyUnread, messagesUnread];

  @override
  bool get stringify => true;

  HomeState({
    @required this.basketballUnread,
    @required this.hockeyUnread,
    @required this.messagesUnread,
  });
}

extension on int {
  String get zeroRule => this == 0 ? '' : this.toString();

  String get ninePlusRule => this > 9 ? '9+' : this.zeroRule;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BasketballPlayerRepository basketballRepo;
  final HockeyPlayerRepository hockeyRepo;
  final MessagesRepository messagesRepo;
  StreamSubscription subscription;

  @override
  HomeState get initialState => HomeState(
        basketballUnread: '',
        hockeyUnread: '',
        messagesUnread: '',
      );

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is _EntityUpdate) {
      final all = event.entities.where((it) => it.isUnread);
      yield HomeState(
        basketballUnread: all.whereType<BasketballPlayer>().length.ninePlusRule,
        hockeyUnread: all.whereType<HockeyPlayer>().length.ninePlusRule,
        messagesUnread: all.whereType<Message>().length.ninePlusRule,
      );
    }
  }

  HomeBloc({
    @required this.basketballRepo,
    @required this.hockeyRepo,
    @required this.messagesRepo,
  }) {
    subscription = Rx.combineLatest3(
        basketballRepo.listen(), hockeyRepo.listen(), messagesRepo.listen(),
        (a, b, c) {
      return List<Entity>.of(a) + List<Entity>.of(b) + List<Entity>.of(c);
    }).listen(
      (it) => add(_EntityUpdate(it)),
    );
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}
