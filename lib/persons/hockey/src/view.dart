import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';
import 'package:worldrtesttask/persons/persons.dart';

class HockeyPlayersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntityBloc<HockeyPlayer>(
        repository: context.repository<HockeyPlayerRepository>(),
      ),
      child: BlocBuilder<EntityBloc<HockeyPlayer>, EntityState>(
        builder: (context, state) {
          if (state is Loaded)
            return Scrollbar(
              child: ListView.builder(
                itemCount: state.entities.length,
                itemBuilder: (_, i) {
                  final hockeyPlayer = state.entities[i];
                  return ActWhenViewed(
                    key: ValueKey(hockeyPlayer.id),
                    hasToAct: hockeyPlayer.isUnread,
                    onViewed: () => context
                        .bloc<EntityBloc<HockeyPlayer>>()
                        .add(MarkRead(hockeyPlayer)),
                    child: Bubble(
                      child: PersonWithAvatar(
                        person: hockeyPlayer,
                        isAvatarAtEnd: hockeyPlayer.alignRight,
                      ),
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
