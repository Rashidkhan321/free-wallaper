

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  String subtitle;
   CustomAppBar({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RichText(
            textAlign: TextAlign.center,

            text: TextSpan(

                text: title,style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.black),
                children: [



          TextSpan(text: subtitle,style: TextStyle(
              fontSize: 26,
              color: Colors.blue,
          fontWeight: FontWeight.w600))

        ])),
      ),
    );
  }
}
