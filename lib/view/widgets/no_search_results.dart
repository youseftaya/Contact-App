import 'package:flutter/material.dart';

class NoSearchResults extends StatelessWidget {
  final Color textColor;
  final Color secondaryTextColor;

  const NoSearchResults({
    super.key,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: secondaryTextColor,
          ),
          const SizedBox(height: 15),
          Text(
            'No Contacts Found',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try another name or phone number',
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}