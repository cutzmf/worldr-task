import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/persons/persons.dart';

abstract class Message implements Entity {
  String get id;

  Person get from;

  String get text;
}
