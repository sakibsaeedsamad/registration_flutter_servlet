class UserCreationResponse {

  final String address;
  final String role;
  final String gender;
  final String dob;
  final String name;
  final String mobile;
  final String errorMessage;
  final String errorCode;
  final String email;
  final String age;

  UserCreationResponse({
    required this.address,
    required this.role,
    required this.gender,
    required this.dob,
    required this.name,
    required this.mobile,
    required this.errorMessage,
    required this.errorCode,
    required this.email,
    required this.age,
  });

  factory UserCreationResponse.fromJson(Map<String, dynamic> json) {
    return UserCreationResponse(
      address: json['address'] as String,
      role: json['role'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      errorMessage: json['errorMessage'] as String,
      errorCode: json['errorCode'] as String,
      email: json['email'] as String,
      age: json['age'] as String,
    );
  }
}