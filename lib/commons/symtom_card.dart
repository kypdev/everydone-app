import 'package:flutter/material.dart';

final String _kanit = 'Kanit';

class SymtomCard extends StatelessWidget {
  final title;
  final desc;

  SymtomCard({@required this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(title),
          Text(desc),
        ],
      ),
    );
  }
}




