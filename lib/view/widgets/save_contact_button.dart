import 'package:flutter/material.dart';

class SaveContactButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  const SaveContactButton({
    super.key,
    required this.onPressed,
    this.text = 'Save Contact',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          disabledBackgroundColor: Colors.lightBlue.shade300,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          isLoading ? 'Loading...' : text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}