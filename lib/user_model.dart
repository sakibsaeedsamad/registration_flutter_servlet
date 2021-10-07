class User {

  final String address;
  final String role;
  final String gender;
  final String roledesc;
  final String dob;
  final String name;
  final String mobile;
  final String email;
  final String age;

  User({
    required this.address,
    required this.role,
    required this.gender,
    required this.roledesc,
    required this.dob,
    required this.name,
    required this.mobile,
    required this.email,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'] as String,
      role: json['role'] as String,
      gender: json['gender'] as String,
      roledesc: json['roledesc'] as String,
      dob: json['dob'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      age: json['age'] as String,
    );
  }
}