import 'package:flutter/material.dart';

class ProfileNameField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Name',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}