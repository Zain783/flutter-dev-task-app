class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({required this.name, required this.email, required this.password});

  // Factory method to create a User object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Method to convert User object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
