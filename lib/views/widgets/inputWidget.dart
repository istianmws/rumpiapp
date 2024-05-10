import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputWidget({
    Key? key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.isPassword,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {},
        )
            : null,
      ),
    );
  }
}
