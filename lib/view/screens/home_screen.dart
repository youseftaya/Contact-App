import 'package:flutter/material.dart';

import '../../core/app_routes.dart';
import '../../data/model/contact_model.dart';
import '../../data/services/firebase_service.dart';
import '../widgets/contact_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService firebaseService = FirebaseService();

  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> deleteContact(
    BuildContext context,
    ContactModel contact,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Delete Contact?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${contact.name}?',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    try {
      await firebaseService.deleteContact(contact.id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Contact deleted successfully',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  void openAddContact(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.addContact,
    );
  }

  void openEditContact(
    BuildContext context,
    ContactModel contact,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.addContact,
      arguments: contact,
    );
  }

  List<ContactModel> filterContacts(
    List<ContactModel> contacts,
  ) {
    if (searchQuery.trim().isEmpty) {
      return contacts;
    }

    final query = searchQuery.trim().toLowerCase();

    return contacts.where((contact) {
      final name = contact.name.toLowerCase();
      final phone = contact.phone.toLowerCase();

      return name.contains(query) || phone.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Contacts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          openAddContact(context);
        },
        child: const Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<List<ContactModel>>(
        stream: firebaseService.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final contacts = snapshot.data ?? [];

          if (contacts.isEmpty) {
            return _buildEmptyState();
          }

          final filteredContacts = filterContacts(contacts);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  8,
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
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
                            onPressed: () {
                              searchController.clear();

                              setState(() {
                                searchQuery = '';
                              });
                            },
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
              ),
              Expanded(
                child: filteredContacts.isEmpty
                    ? _buildNoSearchResults()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];

                          return ContactCard(
                            contact: contact,
                            onEdit: () {
                              openEditContact(
                                context,
                                contact,
                              );
                            },
                            onDelete: () {
                              deleteContact(
                                context,
                                contact,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contact icon
            Icon(
              Icons.contacts_outlined,
              size: 80,
              color: Colors.lightBlue,
            ),

            SizedBox(height: 25),

            Text(
              'No Contacts Yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Add your first contact to get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
          Text(
            'No Contacts Found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try another name or phone number',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}