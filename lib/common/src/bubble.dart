import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:worldrtesttask/utils/context_extension.dart';

class Bubble extends StatelessWidget {
  static Color color = Colors.grey.shade300;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(
          horizontal: context.screenHeight / 48,
          vertical: context.screenHeight / 64),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(context.screenHeight / 24),
      ),
      child: child,
    );
  }

  const Bubble({
    @required this.child,
  });
}
