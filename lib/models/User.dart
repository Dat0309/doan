// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? username;
  String? password;
  String? bankinkNumber;
  int? bankingBalance;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.username,
    this.password,
    this.bankinkNumber,
    this.bankingBalance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'username': username,
      'password': password,
      'banking_number': bankinkNumber,
      'banking_balance': bankingBalance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      bankinkNumber: map['banking_number'] != null
          ? map['banking_number'] as String
          : null,
      bankingBalance:
          map['banking_balance'] != null ? map['banking_balance'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, userName: $username, password: $password, bankinkNumber: $bankinkNumber, bankingBalance: $bankingBalance)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.username == username &&
        other.password == password &&
        other.bankinkNumber == bankinkNumber &&
        other.bankingBalance == bankingBalance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        username.hashCode ^
        password.hashCode ^
        bankinkNumber.hashCode ^
        bankingBalance.hashCode;
  }
}
