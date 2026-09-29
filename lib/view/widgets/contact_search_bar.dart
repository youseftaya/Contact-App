import 'package:flutter/material.dart';

class ContactSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const ContactSearchBar({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Search contacts...',
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: onClear,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
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
    );
  }
}