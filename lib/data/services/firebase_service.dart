import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/contact_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addContact(ContactModel contact) async {
    await _firestore.collection('contacts').add({
      'name': contact.name,
      'phone': contact.phone,
    });
  }

  Stream<List<ContactModel>> getContacts() {
    return _firestore.collection('contacts').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final data = doc.data();

            return ContactModel(
              id: doc.id,
              name: data['name'] ?? '',
              phone: data['phone'] ?? '',
            );
          },
        ).toList();
      },
    );
  }

  Future<void> updateContact(ContactModel contact) async {
    await _firestore
        .collection('contacts')
        .doc(contact.id)
        .update({
      'name': contact.name,
      'phone': contact.phone,
    });
  }

  Future<void> deleteContact(String id) async {
    await _firestore
        .collection('contacts')
        .doc(id)
        .delete();
  }
}