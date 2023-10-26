import 'dart:convert';
import 'package:doan/models/AuthModel.dart';
import 'package:doan/models/ProfileModel.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:doan/services/repositories/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool isLoadedProfile = false;
  num savedBalance = 0;

  late Profile? profile;
  List<dynamic> favProductList = [];
  List<dynamic> favRestaurantList = [];

  void updateBalance(num balance) {
    savedBalance = balance;
    update();
  }

  Future<void> getProfile() async {
    await userRepo.getProfile().then((value) {
      if (value.statusCode == 200) {
        final Map<String, dynamic> resData = json.decode(value.body);

        if (resData.isNotEmpty) {
          profile = Profile.fromMap(resData);
          isLoadedProfile = true;
          savedBalance = profile!.bankingBalance!;
          update();
        }
      }
    });
  }

  Future<bool> checkBankingNumber(String bankingNumber) async {
    bool result = false;
    await userRepo.checkBankingNumber(bankingNumber).then((value) {
      if (value.statusCode == 200) {
        result = true;
        update();
      }
      result = false;
      update();
    });
    return result;
  }

  Future<Map<String, dynamic>> increateBalance(num balance) async {
    var result;
    await userRepo.increateBalance(balance).then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        result = json.decode(value.body);
        savedBalance = result['banking_balance'];
        update();
      }
    });
    return result;
  }

  Future<Map<String, dynamic>> decreateBalance(num balance) async {
    var result;
    await userRepo.decreateBalance(balance).then((value) {
      if (value.statusCode == 200) {
        result = json.decode(value.body);
        savedBalance = result['banking_balance'];
        update();
      }
    });
    return result;
  }

  Future<AuthModel> getUser() async {
    return await UserPreference().getUser();
  }

  String get getName => userRepo.getName;
  String get getLastName => userRepo.getLastName;
  String get getPhoneNumber => userRepo.getPhoneNumber;
  String get getBankingNumber => userRepo.getBankingNumber;
  num get getBankingBalance => userRepo.getBankingBalance;
}
