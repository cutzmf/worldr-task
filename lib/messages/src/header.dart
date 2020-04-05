import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessagesHeader extends StatelessWidget {
  final Function onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent.withOpacity(.4),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => onBack(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Messages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  const MessagesHeader({
    @required this.onBack,
  });
}
