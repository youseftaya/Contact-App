import 'package:flutter/material.dart';

class ProfileThemeTile extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ProfileThemeTile({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
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
            isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode,
            color: isDarkMode
                ? Colors.white
                : Colors.black,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              isDarkMode
                  ? 'Dark Mode'
                  : 'Light Mode',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: isDarkMode,
            activeColor: Colors.lightBlue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}