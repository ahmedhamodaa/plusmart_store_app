import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onChanged;
  final bool obscureText;
  final String hintText;

  const CustomTextFormField({
    super.key,
    required this.onChanged,
    this.obscureText = false,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscureText,
    );
  }
}
