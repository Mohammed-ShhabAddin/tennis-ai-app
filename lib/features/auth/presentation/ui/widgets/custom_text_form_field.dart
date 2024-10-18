import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextStyle? labelStyle;
  final String? hintText;

  final EdgeInsetsGeometry? contentPadding;
  final bool alwaysFloatLabel;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.contentPadding,
    this.labelStyle,
    this.alwaysFloatLabel = false,
    this.inputType = TextInputType.text,
    required this.validator,
    this.isPasswordField = false,
    this.hintText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.isPasswordField ? _obscureText : false,
      validator: widget.validator,
      cursorColor: AppColors.xBlueColor,
      style: const TextStyle(color: AppColors.xBlueColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.xBlueColor.withOpacity(0.6),
          height: 1.5,
        ),
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ??
            const TextStyle(
              color: AppColors.xBlueColor,
              height: 1.5,
            ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        floatingLabelBehavior: widget.alwaysFloatLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: AppColors.xBlueColor,
            width: 2.0,
          ),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.xBlueColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
