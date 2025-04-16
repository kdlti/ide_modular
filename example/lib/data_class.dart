class Client {
  final String name;
  final String address;
  final String email;
  final String phone;

  Client({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  Map toJson() => {
        'name': name,
        'address': address,
        'email': email,
        'phone': phone,
      };
}
