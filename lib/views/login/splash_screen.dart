import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/home/home.dart';
import 'package:doan/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return AnimatedSplashScreen(
          duration: 3000,
          backgroundColor: AppColors.primaryColor!,
          splash: Lottie.asset('assets/images/foody.json'),
          splashIconSize: Dimensions.screenHeight * 0.4,
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          nextScreen:
              controller.userLogged ? const Home() : const LoginScreen());
    });
  }
}
