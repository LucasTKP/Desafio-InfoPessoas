class LoginModel {
  final String id;
  final String username;
  LoginModel({
    required this.id,
    required this.username,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json['uuid'] as String,
    username: json['username'] as String,
  );

  Map<String, dynamic> toJson() => {
    'uuid': id,
    'username': username,
  };
}
