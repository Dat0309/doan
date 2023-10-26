import 'package:doan/constants/app_constant.dart';
import 'package:doan/models/AuthModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(AuthModel auth) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString('first_name', auth.firstName!);
    sharedPreferences.setString('last_name', auth.lastName!);
    sharedPreferences.setString('id', auth.id!);
    sharedPreferences.setString("banking_number", auth.bankingNumber!);
    sharedPreferences.setInt('banking_balance', auth.bankingBalance!.toInt());
    sharedPreferences.setString('token', auth.token!);
    sharedPreferences.setString('createdAt', auth.createAt!);
    sharedPreferences.setString('phone_number', auth.phoneNumber!);

    return sharedPreferences.commit();
  }

  Future<AuthModel> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? id = sharedPreferences.getString("id");
    String? createAt = sharedPreferences.getString("createAt");
    String? bankingNumber = sharedPreferences.getString("banking_number");
    String? token = sharedPreferences.getString("token");
    String? firstName = sharedPreferences.getString("first_name");
    String? lastName = sharedPreferences.getString("last_name");
    num? bankingBalance = sharedPreferences.getInt("banking_balance");
    String? phoneNumber = sharedPreferences.getString("phone_number");

    return AuthModel(
        id: id,
        bankingNumber: bankingNumber,
        createAt: createAt,
        token: token,
        firstName: firstName,
        lastName: lastName,
        bankingBalance: bankingBalance,
        phoneNumber: phoneNumber);
  }

  void removeUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.remove('first_name');
    sharedPreferences.remove('last_name');
    sharedPreferences.remove('id');
    sharedPreferences.remove("banking_number");
    sharedPreferences.remove('banking_balance');
    sharedPreferences.remove('token');
    sharedPreferences.remove('createdAt');
    sharedPreferences.remove('phone_number');
  }

  Future<String> getToken() async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    String result = "";
    if (sharedPreference.containsKey(AppConstant.TOKEN)) {
      result = sharedPreference.getString(AppConstant.TOKEN)!;
    }
    return result;
  }
}
