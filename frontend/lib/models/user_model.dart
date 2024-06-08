class User {
  int? id;
  String? token;
  String? username;
  String? email;
  String? first_name;
  String? last_name;

  User({
    this.email,
    this.first_name,
    this.last_name,
    this.id,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['pk'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
    );
  }
}