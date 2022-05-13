import 'package:flutter/material.dart';

class OurTextField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final String? Function(String?) validate;
  final TextEditingController controller;
  const OurTextField({
    Key? key,
    required this.labelText,
    this.obscure = false,
    required this.controller,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white)),
      child: TextFormField(
        validator: validate,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obscure,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
