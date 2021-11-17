import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {

  final String title;
  CustomHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontWeight: FontWeight.w900
    ),);
  }
}
