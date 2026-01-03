import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {

  final IconData icon;
  final String text;

  const TitleWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 100, color: Colors.white,),
        SizedBox(height: 16,),
        Text(text, style: TextStyle(fontSize: 42,fontWeight: FontWeight.w400,

        color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
