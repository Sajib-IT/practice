import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String title;
  final String value;
  const MyRichText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.black),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),
          ),
          TextSpan(
            text: value,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
