import 'dart:convert';

import 'package:doan/constants/app_url.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo extends GetxService {
  final SharedPreferences sharedPreferences;
  UserRepo({required this.sharedPreferences});

  Future<http.Response> getProfile() async {
    String token = await UserPreference().getToken();
    http.Response res = await http.get(
      Uri.parse(AppUrl.PROFILE),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }

  Future<http.Response> checkBankingNumber(String bankingNumber) async {
    http.Response res = await http.get(
      Uri.parse("${AppUrl.CHECK_BANKINGNUMBER}$bankingNumber"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }

  Future<http.Response> increateBalance(num balance) async {
    final Map<String, dynamic> balanceData = {"banking_balance": balance};
    String token = await UserPreference().getToken();
    http.Response res = await http.put(
      Uri.parse(AppUrl.INCREATE_BALANCE),
      body: json.encode(balanceData),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }

  Future<http.Response> decreateBalance(num balance) async {
    final Map<String, dynamic> balanceData = {"banking_balance": balance};
    String token = await UserPreference().getToken();
    http.Response res = await http.put(
      Uri.parse(AppUrl.DECREATE_BALANCE),
      body: json.encode(balanceData),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }

  String get getName => sharedPreferences.containsKey('first_name')
      ? sharedPreferences.getString('first_name')!
      : "";
  String get getLastName => sharedPreferences.containsKey('last_name')
      ? sharedPreferences.getString('last_name')!
      : "";
  String get getBankingNumber => sharedPreferences.containsKey('banking_number')
      ? sharedPreferences.getString('banking_number')!
      : "";
  num get getBankingBalance => sharedPreferences.containsKey('banking_balance')
      ? sharedPreferences.getInt('banking_balance')!
      : 0;
  String get getPhoneNumber => sharedPreferences.containsKey('phone_number')
      ? sharedPreferences.getString('phone_number')!
      : "0000000000";
}
