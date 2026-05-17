import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final controller, keyboardType, validator, labelText, hintText, prefixIcon,obsecureText;
  const InputField({
    super.key,
    required this.controller,
    required this.obsecureText,
    required this.keyboardType,
    required this.validator,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}
