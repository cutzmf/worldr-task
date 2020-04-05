import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worldrtesttask/fake_it.dart';
import 'package:worldrtesttask/home/home.dart';
import 'package:worldrtesttask/messages/messages.dart';
import 'package:worldrtesttask/persons/basketball/basketball.dart';
import 'package:worldrtesttask/persons/hockey/hockey.dart';

import 'utils/bloc_printer_delegate.dart';

const _basketball_player_box = 'basketball_player_box';
const _hockey_player_box = 'hockey_player_box';
const _messages_player_box = 'messages_player_box';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (const bool.fromEnvironment('dart.vm.product')) {
    /// release mode
  } else {
    BlocSupervisor.delegate = PrinterBlocDelegate();
  }

  await Hive.initFlutter();

  Hive
    ..registerAdapter(HiveBasketballPlayerAdapter())
    ..registerAdapter(HiveMessageAdapter())
    ..registerAdapter(HiveHockeyPlayerAdapter());

  var basketballBox =
      await Hive.openBox<HiveBasketballPlayer>(_basketball_player_box);
  var hockeyBox = await Hive.openBox<HiveHockeyPlayer>(_hockey_player_box);
  var messagesBox = await Hive.openBox<HiveMessage>(_messages_player_box);

  // clear boxes from previous app session
  await Future.wait([
    basketballBox.deleteFromDisk(),
    hockeyBox.deleteFromDisk(),
    messagesBox.deleteFromDisk(),
  ]);

  basketballBox =
      await Hive.openBox<HiveBasketballPlayer>(_basketball_player_box);
  hockeyBox = await Hive.openBox<HiveHockeyPlayer>(_hockey_player_box);
  messagesBox = await Hive.openBox<HiveMessage>(_messages_player_box);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => BasketballPlayerRepository(basketballBox),
        ),
        RepositoryProvider(
          create: (_) => HockeyPlayerRepository(hockeyBox),
        ),
        RepositoryProvider(
          create: (_) => MessagesRepository(messagesBox),
        ),
        RepositoryProvider(
          lazy: false,
          create: (context) => TestTaskFaker(
            basketballBox: basketballBox,
            hockeyBox: hockeyBox,
            messageBox: messagesBox,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordlr Test Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
