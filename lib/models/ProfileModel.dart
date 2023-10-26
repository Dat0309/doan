// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? username;
  String? password;
  String? bankingNumber;
  num? bankingBalance;
  Profile({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.username,
    this.password,
    this.bankingNumber,
    this.bankingBalance,
  });

  Profile copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? username,
    String? password,
    String? bankingNumber,
    num? bankingBalance,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      password: password ?? this.password,
      bankingNumber: bankingNumber ?? this.bankingNumber,
      bankingBalance: bankingBalance ?? this.bankingBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'username': username,
      'password': password,
      'banking_number': bankingNumber,
      'banking_balance': bankingBalance,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      bankingNumber: map['banking_number'] != null
          ? map['banking_number'] as String
          : null,
      bankingBalance:
          map['banking_balance'] != null ? map['banking_balance'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, username: $username, password: $password, bankingNumber: $bankingNumber, bankingBalance: $bankingBalance)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.username == username &&
        other.password == password &&
        other.bankingNumber == bankingNumber &&
        other.bankingBalance == bankingBalance;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        username.hashCode ^
        password.hashCode ^
        bankingNumber.hashCode ^
        bankingBalance.hashCode;
  }
}
