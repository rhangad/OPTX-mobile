

import 'package:flutter/material.dart';

class Collapsible extends StatelessWidget {

  final String title;
  final List<Widget> children;

  Collapsible({ this.title, this.children });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: _CollapsibleTitle(
            title: title,
          ),
          children: children
        ),
      ],
    );
  }
}

class _CollapsibleTitle extends StatelessWidget {

  static final _textLarge = TextStyle(
    fontFamily: "Muli",
    fontSize: 18.0,
    color: _hexToColor('666666'),
  );

  
  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  final String title;

  const _CollapsibleTitle({ this.title });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: _textLarge,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}