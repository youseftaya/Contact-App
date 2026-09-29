import 'package:flutter/material.dart';

class ContactTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const ContactTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color textColor =
        isDarkMode ? Colors.white : Colors.black;

    final Color fieldTextColor =
        isDarkMode ? Colors.black : Colors.black;

    final Color fieldColor = Colors.white;

    final Color hintColor =
        isDarkMode ? Colors.grey.shade600 : Colors.grey.shade600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: fieldTextColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: TextStyle(
              color: hintColor,
            ),

            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),

            filled: true,
            fillColor: fieldColor,

            errorStyle: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.lightBlue,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}