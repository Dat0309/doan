// ignore_for_file: constant_identifier_names

class AppUrl {
  static const int APP_VERSION = 1;
  static const BASEURL = "https://coca-api.vercel.app";
  static const USERS = "$BASEURL/api/v1/user";
  static const ORDERS = "$BASEURL/api/v1/order";
  static const DRINKS = "$BASEURL/api/v1/drink";

  static const LOGIN = "$USERS/login";
  static const REGISTER = USERS;
  static const PROFILE = "$USERS/profile";

  static const CHECK_BANKINGNUMBER = "$USERS/bankingNumber";
  static const INCREATE_BALANCE = "$USERS/increateBalance";
  static const DECREATE_BALANCE = "$USERS/decreateBalance";
}
