import 'package:flutter/material.dart';

class WordTextField extends StatelessWidget{
  final TextEditingController controller;
  final String label;

  const WordTextField({
    super.key,
    required this.controller,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}