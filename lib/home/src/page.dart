import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:worldrtesttask/messages/messages.dart';
import 'package:worldrtesttask/persons/persons.dart';

import 'appbar.dart';
import 'footer.dart';
import 'view.dart';

const footerIcons = [
  FooterIcon(iconData: Icons.home, activeColor: Colors.amber),
  FooterIcon(iconData: Icons.fitness_center, activeColor: Colors.green),
  FooterIcon(iconData: Icons.chat, activeColor: Colors.indigoAccent),
];

const homePage = 0;
const personsPage = 1;
const messagesPage = 2;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const double slideLeft = -1;
  static const double slideRight = 1;
  static const double slideUp = -1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider<TabController>(
        // for nested tab bar in Persons tab
        create: (_) => TabController(
          length: PersonsHeader.tabs.length,
          initialIndex: PersonsHeader.initialIndex,
          vsync: this,
        ),
        child: DefaultTabController(
          length: footerIcons.length,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AnimatedAppBar(
              headers: [
                AnimatedHeader.placeholder(),
                // nothing showed or animated on Home tab
                AnimatedHeader(
                  child: PersonsHeader(),
                  whenMovingLeft: Offset(0, slideUp),
                  whenMovingRight: Offset(slideLeft, 0),
                ),
                AnimatedHeader(
                  child: Builder(builder: (context) {
                    return MessagesHeader(
                      onBack: () {
                        final TabController c =
                            DefaultTabController.of(context);
                        c.animateTo(c.previousIndex);
                      },
                    );
                  }),
                  whenMovingLeft: Offset(slideRight, 0),
                ),
              ],
            ),
            body: _TabsAnimatedSwitcher(
              children: [
                HomeView(),
                PersonsView(),
                MessagesView(),
              ],
            ),
            bottomNavigationBar: FooterBar(footerIcons: footerIcons),
          ),
        ),
      ),
    );
  }
}

class _TabsAnimatedSwitcher extends StatelessWidget {
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (context, child) {
        final distance =
            max((controller.index - controller.previousIndex).abs(), 1);
        final normalizedAnimation =
            (controller.animation.value - controller.previousIndex) / distance;
        final index = (normalizedAnimation.abs() >= .5)
            ? controller.index
            : controller.previousIndex;
        final rotation =
            sin(controller.animation.value * pi / distance) * pi * .5;
        return Transform(
          transform: Matrix4.rotationY(rotation),
          alignment: Alignment.topCenter,
          child: children[index],
        );
      },
    );
  }

  const _TabsAnimatedSwitcher({
    @required this.children,
  });
}
