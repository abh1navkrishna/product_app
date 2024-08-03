import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_app/Constant/Colors.dart';

class AppTextForm extends StatelessWidget {
  const AppTextForm({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keybordType,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keybordType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(8),
          ),
          border: const OutlineInputBorder()),
      keyboardType: keybordType,
      onChanged: onChanged,
    );
  }
}
