import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FooterBar extends StatelessWidget {
  final List<FooterIcon> footerIcons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < footerIcons.length; index++)
            _FooterIconWidget(footerIcon: footerIcons[index], index: index),
        ],
      ),
    );
  }

  const FooterBar({
    @required this.footerIcons,
  });
}

class FooterIcon {
  final IconData iconData;
  final Color activeColor;

  const FooterIcon({
    @required this.iconData,
    @required this.activeColor,
  });
}

class _FooterIconWidget extends StatelessWidget {
  final FooterIcon footerIcon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    return Expanded(
      child: AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return InkWell(
            onTap: () => controller.animateTo(index),
            child: Icon(
              footerIcon.iconData,
              color: ColorTween(
                begin: footerIcon.activeColor,
                end: Colors.white,
              ).evaluate(
                _FooterIconAnimation(
                  controller: controller,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  const _FooterIconWidget({
    @required this.footerIcon,
    @required this.index,
  });
}

class _FooterIconAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  final TabController controller;
  final int index;

  @override
  Animation<double> get parent => controller.animation;

  bool get isJumpOverIndex =>
      controller.indexIsChanging && controller.index != index;

  @override
  double get value =>
      isJumpOverIndex ? 1 : (parent.value - index).clamp(-1.0, 1.0).abs();

  _FooterIconAnimation({
    @required this.controller,
    @required this.index,
  });
}
