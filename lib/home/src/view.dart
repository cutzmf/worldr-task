import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldrtesttask/custom_icons.dart';
import 'package:worldrtesttask/home/src/bloc.dart';
import 'package:worldrtesttask/home/src/page.dart';
import 'package:worldrtesttask/persons/persons.dart';

extension on BoxConstraints {
  Offset get center => Offset(maxWidth / 2, maxHeight / 2);
}

extension on double {
  double get radians => this * pi / 180;
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return HomeBloc(
          basketballRepo: context.repository(),
          hockeyRepo: context.repository(),
          messagesRepo: context.repository(),
        );
      },
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          final controller = DefaultTabController.of(context);
          final personsController = context.repository<TabController>();
          return Stack(
            children: <Widget>[
              _QuickAccessButton(
                iconData: CustomIcons.sports_hockey_24px,
                selectCounterFrom: (state) => state.hockeyUnread,
                isBadgeVisible: (state) => state.hasHockeyUnread,
                onTap: () {
                  controller.animateTo(personsPage);
                  personsController.animateTo(hockeyPlayers);
                },
                parentCenter: boxConstraints.center,
                color: Colors.green,
                angle: -30,
              ),
              _QuickAccessButton(
                iconData: CustomIcons.sports_basketball_24px,
                selectCounterFrom: (state) => state.basketballUnread,
                isBadgeVisible: (state) => state.hasBasketballUnread,
                onTap: () {
                  controller.animateTo(personsPage);
                  personsController.animateTo(basketballPlayers);
                },
                parentCenter: boxConstraints.center,
                color: Colors.green,
                angle: 210,
              ),
              _QuickAccessButton(
                iconData: Icons.chat,
                selectCounterFrom: (state) => state.messagesUnread,
                isBadgeVisible: (state) => state.hasMessagesUnread,
                onTap: () => controller.animateTo(messagesPage),
                parentCenter: boxConstraints.center,
                color: Colors.indigo,
                angle: 90,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QuickAccessButton extends StatelessWidget {
  final Offset parentCenter;
  final Color color;
  final double angle;
  final String Function(HomeState) selectCounterFrom;
  final bool Function(HomeState) isBadgeVisible;
  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final Offset offset =
        parentCenter + Offset.fromDirection(angle.radians, 100);
    final double radius = 70;
    return Positioned(
      top: offset.dy - radius,
      left: offset.dx - radius,
      width: 2 * radius,
      height: 2 * radius,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, boxConstraints) {
            return Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Icon(
                    iconData,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return _Badge(
                      text: selectCounterFrom(state),
                      isVisible: isBadgeVisible(state),
                      offset: boxConstraints.center,
                      distance: boxConstraints.maxWidth / 2,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  const _QuickAccessButton({
    @required this.selectCounterFrom,
    @required this.isBadgeVisible,
    @required this.onTap,
    @required this.parentCenter,
    @required this.color,
    @required this.iconData,
    @required this.angle,
  });
}

class _Badge extends StatelessWidget {
  final String text;
  final bool isVisible;
  final Offset offset;
  static const double radius = 16;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Positioned(
            top: offset.dy - radius,
            left: offset.dx - radius,
            width: 2 * radius,
            height: 2 * radius,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              child: isVisible
                  ? Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          )
        : SizedBox.shrink();
  }

  _Badge({
    @required this.text,
    @required offset,
    @required this.isVisible,
    @required double distance,
  }) : offset = offset + Offset.fromDirection(-55.0.radians, distance);
}
