import 'dart:ui';

import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/models/AuthModel.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/login/login_screen.dart';
import 'package:doan/views/login/widgets/button.dart';
import 'package:doan/views/login/widgets/text_field.dart';
import 'package:doan/views/profile/widget/profile_list_item.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var bankingBalance = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void increateBalance(UserController userController) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.heightPadding20,
              ),
              child: SizedBox(
                height: Dimensions.screenHeight * 0.7,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding10,
                  ),
                  TextFieldCustom(
                    hint: 'Nhập số tiền muốn nạp',
                    icon: Icons.text_fields,
                    controller: bankingBalance,
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding10,
                  ),
                  GestureDetector(
                    onTap: () {
                      userController
                          .increateBalance(int.parse(bankingBalance.text))
                          .then((value) => {
                                // ignore: unnecessary_null_comparison
                                if (value != null)
                                  {
                                    UserPreference()
                                        .saveUser(AuthModel.fromJson(value)),
                                    Get.snackbar(
                                      'Thành công',
                                      'Bạn đã nạp tiền thành công vào tài khoản, số dư: ${value['banking_balance'].toString()}',
                                      backgroundColor: AppColors.primaryColor,
                                      colorText: Colors.white,
                                    )
                                  }
                                else
                                  {
                                    Get.snackbar(
                                      'Thất bại',
                                      'Xảy ra lỗi trong quá trình nạp tiền',
                                      backgroundColor: AppColors.primaryColor,
                                      colorText: Colors.white,
                                    )
                                  }
                              });
                      Get.back();
                    },
                    child: CustomButton(text: 'Xác nhận'),
                  ),
                ]),
              ),
            );
          });
    }

    return Scaffold(
      body: GetBuilder<UserController>(builder: (userController) {
        return userController.isLoadedProfile
            ? Center(
                child: Stack(
                  children: [
                    Container(
                      height: Dimensions.screenHeight,
                      width: Dimensions.screenWidth,
                      color: AppColors.mainBlackColor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            const Color(0xff21242c),
                            const Color(0xff21242c).withOpacity(.9),
                            const Color(0xff21242c).withOpacity(.1),
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: Dimensions.radius20,
                            sigmaY: Dimensions.radius20,
                          ),
                          child: Container(
                            color: const Color(0xff21242c).withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Dimensions.height120 - 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Dimensions.widthPadding15),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text:
                                      "Khách hàng: ${userController.profile!.firstName} ${userController.profile!.lastName}",
                                  color: AppColors.secondaryColor,
                                ),
                                SizedBox(
                                  height: Dimensions.heightPadding30,
                                ),
                                BigText(
                                  text:
                                      'Số tài khoản: ${userController.profile!.bankingNumber}',
                                  color: AppColors.secondaryColor,
                                ),
                                BigText(
                                  text:
                                      'Số điện thoại: ${userController.profile!.phoneNumber}',
                                  color: AppColors.secondaryColor,
                                ),
                                BigText(
                                  text:
                                      'Số dư khả dụng: ${userController.savedBalance.toString()} vnd',
                                  color: AppColors.secondaryColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.heightPadding30,
                          ),
                          GestureDetector(
                            onTap: () {
                              increateBalance(userController);
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.all(Dimensions.widthPadding15),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              child: const BigText(
                                text: "Nạp tiền",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.heightPadding30,
                          ),
                          const ProfileListItem(
                            icon: Icons.privacy_tip_rounded,
                            text: 'Điều khoản',
                          ),
                          const ProfileListItem(
                            icon: Icons.support_agent_rounded,
                            text: 'Hỗ trợ',
                          ),
                          const ProfileListItem(
                            icon: Icons.settings,
                            text: 'Cài đặt',
                          ),
                          const ProfileListItem(
                            icon: Icons.person_add_alt_rounded,
                            text: 'Mời bạn bè',
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<AuthController>().logout().then(
                                    (value) =>
                                        Get.to(() => const LoginScreen()),
                                  );
                            },
                            child: const ProfileListItem(
                              icon: Icons.logout_rounded,
                              text: 'Đăng xuất',
                              hasNavigation: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container();
      }),
    );
  }
}
