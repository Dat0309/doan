import 'dart:convert';

import 'package:doan/constants/app_constant.dart';
import 'package:doan/constants/app_url.dart';
import 'package:doan/models/User.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.sharedPreferences,
  });

  var token = UserPreference().getToken();

  Future saveUserToken(String token) async {
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<void> saveUsernamePassword(String username, String password) async {
    try {
      await sharedPreferences.setString(AppConstant.USERNAME, username);
      await sharedPreferences.setString(AppConstant.PASSWORD, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> login(String username, String password) async {
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    http.Response response = await http.post(
      Uri.parse(AppUrl.LOGIN),
      body: json.encode(loginData),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  Future logout() async {
    return sharedPreferences.clear();
  }

  Future<http.Response> register(User user) async {
    final Map<String, dynamic> registerData = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "username": user.username,
      "password": user.password,
      "banking_number": user.bankinkNumber,
    };

    http.Response response = await http.post(
      Uri.parse(AppUrl.REGISTER),
      body: json.encode(registerData),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  static onError(error) {
    return {
      'status': false,
      'message': 'Unsuccessfull Request',
      'data': error,
    };
  }
}
