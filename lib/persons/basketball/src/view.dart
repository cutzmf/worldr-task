import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/persons.dart';

class BasketballPlayersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntityBloc<BasketballPlayer>(
        repository: context.repository<BasketballPlayerRepository>(),
      ),
      child: BlocBuilder<EntityBloc<BasketballPlayer>, EntityState>(
        builder: (context, state) {
          if (state is Loaded)
            return Scrollbar(
              child: ListView.builder(
                itemCount: state.entities.length,
                itemBuilder: (_, i) {
                  final player = state.entities[i];
                  return ActWhenViewed(
                    key: ValueKey(player.id),
                    hasToAct: player.isUnread,
                    onViewed: () => context
                        .bloc<EntityBloc<BasketballPlayer>>()
                        .add(MarkRead(player)),
                    child: Bubble(
                      child: PersonWithAvatar(person: player),
                    ),
                  );
                },
              ),
            );

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
