import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldrtesttask/common/common.dart';
import 'package:worldrtesttask/persons/src/person_with_avatar.dart';

import 'message.dart';
import 'repository.dart';

final key = GlobalKey();

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntityBloc<Message>(
        repository: context.repository<MessagesRepository>(),
      ),
      child: BlocBuilder<EntityBloc<Message>, EntityState>(
        builder: (context, state) {
          if (state is Loaded)
            return ListView.builder(
              key: key,
              itemCount: state.entities.length,
              itemBuilder: (_, i) {
                final message = state.entities[i];
                return ActWhenViewed(
                  key: ValueKey(message.id),
                  hasToAct: message.isUnread,
                  onViewed: () => context
                      .bloc<EntityBloc<Message>>()
                      .add(MarkRead(message)),
                  child: _Message(message),
                );
              },
            );

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final Message message;

  _Message(this.message);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PersonWithAvatar(person: message.from),
          SizedBox(height: 10),
          _ExpandedText(text: message.text),
        ],
      ),
    );
  }
}

class _ExpandedText extends StatefulWidget {
  final String text;

  @override
  _ExpandedTextState createState() => _ExpandedTextState();

  _ExpandedText({
    @required this.text,
  }) : super(key: ValueKey(text));
}

class _ExpandedTextState extends State<_ExpandedText>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  final collapsedLineEndFade = BoxDecoration(
    gradient: LinearGradient(
      stops: [0.5, 1],
      colors: [
        Bubble.color.withOpacity(0),
        Bubble.color.withOpacity(1),
      ],
    ),
  );

  final expandedLineEndFade = BoxDecoration();

  TextPainter oneLinePainter;
  TextPainter allLinesPainter;

  void toggleExpansion([dynamic _]) {
    if (!oneLinePainter.didExceedMaxLines) return;
    isExpanded = !isExpanded;
    setState(() {});
  }

  TextPainter createPainter(TextSpan textSpan, {int maxLines}) => TextPainter(
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        text: textSpan,
      );

  void updatePaintersWith(double maxWidth) {
    if (oneLinePainter == null && allLinesPainter == null) {
      final textSpan = TextSpan(
        text: widget.text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      );

      oneLinePainter = createPainter(textSpan, maxLines: 1);

      allLinesPainter = createPainter(textSpan);
    }

    oneLinePainter.layout(maxWidth: maxWidth);
    allLinesPainter.layout(maxWidth: maxWidth);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, parent) {
        updatePaintersWith(parent.maxWidth);

        return InkWell(
          onTap: toggleExpansion,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomPaint(
                painter: _CustomTextPainter(textPainter: allLinesPainter),
                child: AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  width:
                      isExpanded ? allLinesPainter.width : oneLinePainter.width,
                  height: isExpanded
                      ? allLinesPainter.height
                      : oneLinePainter.height,
                  decoration: !oneLinePainter.didExceedMaxLines || isExpanded
                      ? expandedLineEndFade
                      : collapsedLineEndFade,
                ),
              ),
              if (oneLinePainter.didExceedMaxLines)
                Center(
                  child: SizedBox(
                    height: 20,
                    child: ExpandIcon(
                      size: 12,
                      isExpanded: isExpanded,
                      onPressed: toggleExpansion,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CustomTextPainter extends CustomPainter {
  final TextPainter textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  const _CustomTextPainter({
    @required this.textPainter,
  });
}
