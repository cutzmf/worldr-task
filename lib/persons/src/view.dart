import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';

class PersonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: Provider.of(context),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        BasketballPlayersView(),
        HockeyPlayersView(),
      ],
    );
  }
}
