import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool alwaysFloatLabel;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.labelStyle,
    this.contentPadding,
    this.alwaysFloatLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ??
            const TextStyle(
              color: AppColors.xBlueColor,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        floatingLabelBehavior: alwaysFloatLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
