import 'package:flutter/material.dart';

import '../../core/app_routes.dart';
import '../../data/model/contact_model.dart';
import '../../data/services/firebase_service.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_empty_state.dart';
import '../widgets/contact_search_bar.dart';
import '../widgets/no_search_results.dart';

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
          title: const Text(
            'Delete Contact?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete ${contact.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
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
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color textColor =
        isDarkMode ? Colors.white : Colors.black;

    final Color secondaryTextColor =
        isDarkMode ? Colors.grey : Colors.grey.shade700;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.profile,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
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
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
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
                style: TextStyle(
                  color: textColor,
                ),
              ),
            );
          }

          final contacts = snapshot.data ?? [];

          if (contacts.isEmpty) {
            return ContactEmptyState(
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            );
          }

          final filteredContacts =
              filterContacts(contacts);

          return Column(
            children: [
              ContactSearchBar(
                controller: searchController,
                searchQuery: searchQuery,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                onClear: () {
                  searchController.clear();

                  setState(() {
                    searchQuery = '';
                  });
                },
              ),

              Expanded(
                child: filteredContacts.isEmpty
                    ? NoSearchResults(
                        textColor: textColor,
                        secondaryTextColor:
                            secondaryTextColor,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact =
                              filteredContacts[index];

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
}