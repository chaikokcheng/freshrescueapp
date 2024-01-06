import 'package:flutter/material.dart';

import 'package:grocery_app/res/custom_colors.dart';
import 'package:grocery_app/styles/colors.dart';

class AppBarTitle extends StatelessWidget {
  final String sectionName;

  const AppBarTitle({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /* Image.asset(
          'assets/login/tech_shrine_logo.png',
          height: 20,
        ),*/
        //SizedBox(width: 8),
        Text(
          ' $sectionName',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
