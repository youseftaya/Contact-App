import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_routes.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/profile_language_tile.dart';
import '../widgets/profile_name_field.dart';
import '../widgets/profile_theme_tile.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  File? profileImage;

  bool isArabic = false;

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    setState(() {
      profileImage = File(pickedImage.path);
    });
  }

  void continueToHome() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your name',
          ),
        ),
      );

      return;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.home,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Image
            ProfileImagePicker(
              profileImage: profileImage,
              onTap: pickImage,
            ),

            const SizedBox(height: 35),

            // Name
            ProfileNameField(
              controller: nameController,
            ),

            const SizedBox(height: 25),

            // Dark / Light
            ProfileThemeTile(
              isDarkMode: isDarkMode,
              onChanged: widget.onThemeChanged,
            ),

            const SizedBox(height: 15),

            // Language
            ProfileLanguageTile(
              isArabic: isArabic,
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  isArabic = value;
                });
              },
            ),

            const SizedBox(height: 35),

            // Continue
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: continueToHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}