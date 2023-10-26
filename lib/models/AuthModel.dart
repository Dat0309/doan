class AuthModel {
  String? id;
  String? firstName;
  String? lastName;
  String? bankingNumber;
  num? bankingBalance;
  String? token;
  String? createAt;
  String? phoneNumber;

  AuthModel({
    required this.id,
    required this.bankingNumber,
    required this.token,
    required this.createAt,
    required this.firstName,
    required this.lastName,
    required this.bankingBalance,
    required this.phoneNumber,
  });

  factory AuthModel.fromJson(Map<String, dynamic> res) {
    return AuthModel(
        id: res['_id'],
        bankingNumber: res['banking_number'],
        token: res['token'],
        createAt: res['createdAt'],
        firstName: res['first_name'],
        lastName: res['last_name'],
        bankingBalance: res['banking_balance'],
        phoneNumber: res['phone_number']);
  }
}
