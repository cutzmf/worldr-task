import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OffsetAnimation extends Animation<Offset>
    with AnimationWithParentMixin<double> {
  final TabController controller;
  final int index;
  final Offset onMoveLeft;
  final Offset onMoveRight;

  @override
  Animation<double> get parent => controller.animation;

  bool get isJumpingOverIndex =>
      controller.indexIsChanging &&
      controller.index != index &&
      controller.previousIndex != index;

  @override
  Offset get value {
    final double notAnimated = 1.0;

    final double animationValue = (parent.value - index).clamp(-1.0, 1.0);

    final double valueMovingLeft = isJumpingOverIndex
        ? notAnimated
        : animationValue.clamp(-1.0, 0.0).abs();

    final double valueMovingRight =
        isJumpingOverIndex ? notAnimated : animationValue.clamp(0.0, 1.0).abs();

    return Offset(
      valueMovingLeft * onMoveLeft.dx + valueMovingRight * onMoveRight.dx,
      valueMovingLeft * onMoveLeft.dy + valueMovingRight * onMoveRight.dy,
    );
  }

  OffsetAnimation({
    @required this.controller,
    @required this.index,
    this.onMoveLeft = Offset.zero,
    this.onMoveRight = Offset.zero,
  });
}
