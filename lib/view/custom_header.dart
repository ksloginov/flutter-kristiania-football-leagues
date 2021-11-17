import 'package:flutter/material.dart';

import '../constants.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  CustomHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.w700,
              color: kSecondaryText,
            ),
      ),
    );
  }
}
