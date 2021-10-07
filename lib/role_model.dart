class Role {

  final String code;
  final String desc;

  Role({
    required this.code,
    required this.desc,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      code: json['code'] as String,
      desc: json['desc'] as String,
    );
  }
}