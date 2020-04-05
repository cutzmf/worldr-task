import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldrtesttask/common/src/offset_animation.dart';
import 'package:worldrtesttask/utils/context_extension.dart';

/// Depends on [DefaultTabController]
class AnimatedAppBar extends PreferredSize {
  final List<AnimatedHeader> headers;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: kToolbarHeight + context.safeTop,
            color: Colors.transparent,
            child: CustomSingleChildLayout(
              delegate: const _AppbarLayoutDelegate(),
              child: Stack(
                children: [
                  for (var index = 0; index < headers.length; index++)
                    _AnimatedContent(
                      index: index,
                      header: headers[index],
                    ),
                  Container(
                    height: context.safeTop,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  AnimatedAppBar({
    @required this.headers,
  });
}

class AnimatedHeader {
  final Widget child;
  final Offset whenMovingLeft;
  final Offset whenMovingRight;

  factory AnimatedHeader.placeholder() =>
      AnimatedHeader(child: SizedBox.shrink());

  const AnimatedHeader({
    @required this.child,
    this.whenMovingLeft = Offset.zero,
    this.whenMovingRight = Offset.zero,
  });
}

class _AnimatedContent extends StatelessWidget {
  final int index;
  final AnimatedHeader header;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      height: kToolbarHeight + context.safeTop,
      child: SlideTransition(
        position: OffsetAnimation(
          controller: DefaultTabController.of(context),
          index: index,
          onMoveLeft: header.whenMovingLeft,
          onMoveRight: header.whenMovingRight,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: context.safeTop),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: header.child,
            ),
          ),
        ),
      ),
    );
  }

  const _AnimatedContent({
    @required this.index,
    @required this.header,
  });
}

class _AppbarLayoutDelegate extends SingleChildLayoutDelegate {
  const _AppbarLayoutDelegate();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: kToolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_AppbarLayoutDelegate oldDelegate) => false;
}
