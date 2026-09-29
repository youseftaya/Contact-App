import 'package:flutter/material.dart';

class ProfileLanguageTile extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool?> onChanged;

  const ProfileLanguageTile({
    super.key,
    required this.isArabic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey.shade900
            : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: isDarkMode
                ? Colors.white
                : Colors.black,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              'Language',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DropdownButton<bool>(
            value: isArabic,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(
                value: false,
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: true,
                child: Text('العربية'),
              ),
            ],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}