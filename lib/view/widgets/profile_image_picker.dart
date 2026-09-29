import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onTap;

  const ProfileImagePicker({
    super.key,
    required this.profileImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.lightBlue,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : null,
                child: profileImage == null
                    ? const Icon(
                        Icons.person,
                        size: 65,
                        color: Colors.white,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to change photo',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey
                : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}