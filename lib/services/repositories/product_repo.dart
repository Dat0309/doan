import 'package:doan/constants/app_url.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductRepo extends GetxService {
  ProductRepo();

  var token = UserPreference().getToken();
  Future<http.Response> getProductList() async {
    http.Response res = await http.get(
      Uri.parse(AppUrl.DRINKS),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }
}
