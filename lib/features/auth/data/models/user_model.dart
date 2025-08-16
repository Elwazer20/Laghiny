import 'dart:convert';

class User {
  final String? fullName;
  final String email;

  User({required this.fullName, required this.email});

  User copyWith({String? fullName, String? email}) {
    return User(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {'fullName': fullName, 'email': email};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  @override
  String toString() => 'User(fullName: $fullName, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.fullName == fullName;
  }

  @override
  int get hashCode => fullName.hashCode ^ email.hashCode;
}
