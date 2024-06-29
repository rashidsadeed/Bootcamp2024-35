import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  //const CustomButton({super.key});
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
