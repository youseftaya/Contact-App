import 'package:flutter/material.dart';

import '../../data/model/contact_model.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.black,
                child: Text(
                  contact.name[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 17,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          contact.phone,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: onDelete,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}