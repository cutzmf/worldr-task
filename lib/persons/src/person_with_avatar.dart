import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:worldrtesttask/common/src/avatar_colors.dart';
import 'package:worldrtesttask/persons/persons.dart';
import 'package:worldrtesttask/utils/context_extension.dart';

class PersonWithAvatar extends StatelessWidget {
  final Person person;
  final TextDirection _textDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: _textDirection,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: avatarColorFromString(person.id),
          radius: context.screenHeight / 24,
        ),
        SizedBox(width: 18),
        Expanded(
          child: Text(
            '${person.name}',
            textDirection: _textDirection,
            maxLines: 2,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 18),
      ],
    );
  }

  const PersonWithAvatar({
    @required this.person,
    bool isAvatarAtEnd = false,
  }) : _textDirection = isAvatarAtEnd ? TextDirection.rtl : TextDirection.ltr;
}
