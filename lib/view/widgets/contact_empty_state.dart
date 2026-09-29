import 'package:flutter/material.dart';

class ContactEmptyState extends StatelessWidget {
  final Color textColor;
  final Color secondaryTextColor;

  const ContactEmptyState({
    super.key,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.contacts_outlined,
              size: 80,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 25),
            Text(
              'No Contacts Yet',
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Add your first contact to get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}