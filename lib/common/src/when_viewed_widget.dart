import 'package:flutter/widgets.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ActWhenViewed extends StatelessWidget {
  final Widget child;
  final Function onViewed;
  final bool hasToAct;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: hasToAct ? onViewed() : null,
      child: child,
    );
  }

  const ActWhenViewed({
    @required this.child,
    @required this.hasToAct,
    @required this.onViewed,
    @required this.key,
  });
}
