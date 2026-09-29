class ContactModel {
  final String name;
  final String phone;
  final String id;

  const ContactModel({
    this.id = '',
    required this.name,
    required this.phone,
  });
}