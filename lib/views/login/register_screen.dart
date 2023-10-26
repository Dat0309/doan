import 'dart:math';

import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/models/User.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/login/login_screen.dart';
import 'package:doan/views/login/widgets/button.dart';
import 'package:doan/views/login/widgets/password_field.dart';
import 'package:doan/views/login/widgets/rich_text.dart';
import 'package:doan/views/login/widgets/text_field.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var phonenumberController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordCofirmController = TextEditingController();
  var bankNumberController = TextEditingController();

  void checkAndGenerateBankingNumber() {
    var random = Random();
    int bankingNumber = random.nextInt(100000000);
    bankNumberController.text = bankingNumber.toString();
    Get.find<UserController>()
        .checkBankingNumber(bankingNumber.toString())
        .then((value) => {
              if (value)
                {
                  Get.snackbar(
                    'Lỗi rồi',
                    'Số tài khoản đã có người sử dụng, vui lòng chọn số khác',
                    backgroundColor: AppColors.primaryColor,
                    colorText: Colors.white,
                  )
                }
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAndGenerateBankingNumber();
  }

  @override
  Widget build(BuildContext context) {
    void register(AuthController controller) {
      User user = User(
          firstName: firstnameController.text,
          lastName: lastnameController.text,
          phoneNumber: phonenumberController.text,
          username: usernameController.text,
          password: passwordController.text,
          bankinkNumber: bankNumberController.text);
      if (passwordCofirmController.text.compareTo(passwordController.text) ==
          0) {
        controller.register(user).then((value) {
          if (value['status']) {
            Get.snackbar(
              'Đăng ký tài khoản thành công',
              'Đăng ký tài khoản thành công, xin mời đăng nhập',
              backgroundColor: AppColors.thirthColor,
              colorText: Colors.white,
            );
            Get.off(() => const LoginScreen());
          } else {
            Get.snackbar(
              'Đăng ký thất bại',
              'Đã có lỗi sảy ra trong quá trình đăng ký',
              backgroundColor: AppColors.signColor,
              colorText: Colors.white,
            );
          }
        });
      } else {
        Get.snackbar(
          'Đăng ký thất bại',
          'Mật khẩu không trùng khớp! xin mời kiểm tra lại',
          backgroundColor: AppColors.signColor,
          colorText: Colors.white,
        );
      }
    }

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SizedBox(
            width: Dimensions.screenWidth,
            height: Dimensions.screenHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.screenWidth * 0.06,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.heightPadding15,
                    ),
                    RichTextCustom(
                      fontSize: Dimensions.screenWidth / 15,
                      headerText: 'Đăng',
                      footerText: 'Ký',
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: Dimensions.heightPadding60 + 20,
                      width: Dimensions.widthPadding60 + 20,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding20,
                    ),
                    const BigText(
                      text: 'Thông tin người dùng',
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding20,
                    ),
                    TextFieldCustom(
                      hint: 'Họ',
                      icon: Icons.text_fields,
                      controller: lastnameController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding10,
                    ),
                    TextFieldCustom(
                      hint: 'Tên',
                      icon: Icons.text_fields,
                      controller: firstnameController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding10,
                    ),
                    TextFieldCustom(
                      hint: 'Số điện thoại',
                      icon: Icons.phone,
                      controller: phonenumberController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding20,
                    ),
                    const BigText(
                      text: 'Thông tin đăng nhập',
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding20,
                    ),
                    TextFieldCustom(
                      hint: 'Tên đăng nhập',
                      icon: Icons.text_fields,
                      controller: usernameController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding10,
                    ),
                    PasswordField(
                      suffixIcon: Icons.visibility,
                      hint: 'Mật khẩu',
                      icon: Icons.lock,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding10,
                    ),
                    PasswordField(
                      suffixIcon: Icons.visibility,
                      hint: 'Xác nhận mật khẩu',
                      icon: Icons.lock,
                      controller: passwordCofirmController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding20,
                    ),
                    const BigText(
                      text: 'Thông tin tài khoản',
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.widthPadding20,
                    ),
                    TextFieldCustom(
                      hint: bankNumberController.text,
                      icon: Icons.money,
                      controller: bankNumberController,
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding30,
                    ),
                    GestureDetector(
                      onTap: () {
                        register(authController);
                      },
                      child: const CustomButton(
                        text: 'Đăng ký',
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.heightPadding15 + 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
