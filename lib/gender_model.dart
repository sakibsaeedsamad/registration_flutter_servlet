class Gender {

  final String genCode;
  final String genDesc;

  Gender({
    required this.genCode,
    required this.genDesc,
  });

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      genCode: json['genCode'] as String,
      genDesc: json['genDesc'] as String,
    );
  }
}