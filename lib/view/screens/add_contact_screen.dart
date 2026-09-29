import 'package:flutter/material.dart';

import '../../data/model/contact_model.dart';
import '../../data/services/firebase_service.dart';
import '../widgets/contact_text_field.dart';
import '../widgets/save_contact_button.dart';

class AddContactScreen extends StatefulWidget {
  final ContactModel? contact;

  const AddContactScreen({
    super.key,
    this.contact,
  });

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseService firebaseService = FirebaseService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  bool get isEditing => widget.contact != null;

  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      nameController.text = widget.contact!.name;
      phoneController.text = widget.contact!.phone;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> saveContact() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    try {
      if (isEditing) {
        final updatedContact = ContactModel(
          id: widget.contact!.id,
          name: name,
          phone: phone,
        );

        await firebaseService.updateContact(updatedContact);
      } else {
        final newContact = ContactModel(
          name: name,
          phone: phone,
        );

        await firebaseService.addContact(newContact);
      }

      await Future.delayed(
        const Duration(seconds: 1),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color textColor =
        isDarkMode ? Colors.white : Colors.black;

    final Color backgroundColor =
        isDarkMode ? Colors.black : const Color(0xFFF5F5F5);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,

          appBar: AppBar(
            title: Text(
              isEditing ? 'Edit Contact' : 'Add Contact',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing
                        ? 'Edit Contact'
                        : 'Add New Contact',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ContactTextField(
                    controller: nameController,
                    label: 'Name',
                    hintText: 'Enter your name',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter a name';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  ContactTextField(
                    controller: phoneController,
                    label: 'Phone',
                    hintText: 'Enter phone number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter a phone number';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SaveContactButton(
                    onPressed: isLoading
                        ? null
                        : saveContact,
                    text: isEditing
                        ? 'Update Contact'
                        : 'Save Contact',
                  ),
                ],
              ),
            ),
          ),
        ),

        // Loading
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
              child: Center(
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 45,
                        color: Colors.lightBlue,
                      ),

                      SizedBox(height: 15),

                      Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}