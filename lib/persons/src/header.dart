import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:worldrtesttask/common/src/offset_animation.dart';

const basketballPlayers = 0;
const hockeyPlayers = 1;

class PersonsHeader extends StatelessWidget {
  static const tabs = ['Basketball', 'Hockey'];

  static const initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.5),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _AnimatedInactiveBackground(),

          /// dirty hack - used 2 TabBar's not to write custom animations for underline indicator
          ///
          /// This one renders expanded containers so full tab area is clickable
          TabBar(
            controller: Provider.of(context),
            indicatorColor: Colors.transparent,
            tabs: [
              for (var _ in tabs)
                Container(constraints: BoxConstraints.expand()),
            ],
          ),

          /// This renders tab names & tab underline indicator right under names
          Center(
            child: TabBar(
              controller: Provider.of(context),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.white,
              tabs: tabs.map((it) => Text(it)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedInactiveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: OffsetAnimation(
        controller: Provider.of(context),
        index: PersonsHeader.initialIndex + 1,
        onMoveLeft: Offset(1, 0),
        onMoveRight: Offset(-1, 0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth / PersonsHeader.tabs.length,
            color: Colors.green.withOpacity(.5),
          );
        },
      ),
    );
  }
}
