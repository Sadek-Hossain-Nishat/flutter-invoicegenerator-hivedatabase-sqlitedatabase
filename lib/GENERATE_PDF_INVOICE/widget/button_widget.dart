import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          backgroundColor: Colors.deepOrange
        ),


        onPressed: onClicked, child: FittedBox(
      child: Text(text,
      style: TextStyle(fontSize: 20,color: Colors.white),),
    ));
  }
}
