import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final String prefix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  const CustomTextFormField(
      {Key? key,
      this.initialValue,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.prefix = '',
      this.textCapitalization = TextCapitalization.none,
      this.onChanged,
      this.maxLines = 1,
      this.onSaved,
      this.validator,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
            hintText: hintText, labelText: labelText, prefix: Text(prefix)),
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        onSaved: onSaved);
  }
}
