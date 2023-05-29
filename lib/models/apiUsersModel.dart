class APiUser {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  APiUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory APiUser.fromJson(Map<String, dynamic> json) {
    return APiUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }
}
