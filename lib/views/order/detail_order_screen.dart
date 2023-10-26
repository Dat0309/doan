import 'dart:ffi';

import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/models/Order.dart';
import 'package:doan/models/User.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/home/home.dart';
import 'package:doan/views/login/widgets/button.dart';
import 'package:doan/widgets/app_icon.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:doan/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailBookingScreen extends StatefulWidget {
  final Order bookingResult;
  final Map<String, dynamic> userOrder;
  const DetailBookingScreen(
      {Key? key, required this.bookingResult, required this.userOrder})
      : super(key: key);

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pargColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.radius30),
            child: Container(
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: Dimensions.heightPadding10,
                      top: 100,
                    ),
                    child: BigText(
                        text:
                            'Khách hàng: ${widget.userOrder['last_name']} ${widget.userOrder['first_name']}'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: Dimensions.heightPadding10,
                    ),
                    child: SmallText(
                        text: 'Liên lạc: ${widget.userOrder['phone_number']}'),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: Dimensions.heightPadding10),
                    child: const BigText(
                      text: 'Danh sách mua:',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding45,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.bookingResult.orderItems!.length,
                        itemBuilder: (context, indexItem) {
                          return Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.widthPadding20 / 2),
                            child: Hero(
                              tag:
                                  "${widget.bookingResult.orderItems![indexItem].product}_bookingTag",
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      widget.bookingResult
                                          .orderItems![indexItem].image!,
                                    ),
                                  ),
                                  AppIcon(
                                    size: Dimensions.heightPadding20,
                                    iconColor: Colors.transparent,
                                    backgroundColor:
                                        AppColors.secondaryIconColor,
                                    icon: Icons.circle,
                                  ),
                                  Positioned(
                                    left: 3,
                                    child: BigText(
                                      text: widget.bookingResult
                                          .orderItems![indexItem].qty!
                                          .toString(),
                                      size: Dimensions.font16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding30,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: Dimensions.heightPadding10),
                    child: SmallText(
                      text:
                          'Số tiền thanh toán: ${widget.bookingResult.totalPrice.toString()} vnd',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: Dimensions.heightPadding10),
                    child: SmallText(
                      text:
                          'Số dư tài khoản: ${widget.userOrder['banking_balance']} vnd',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding30,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: Dimensions.heightPadding10),
                    child: const BigText(
                      text: 'Cảm ơn quý khách đã sử dụng dịch vụ',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      31,
                      (index) => const Text(
                        '- ',
                        style: TextStyle(
                          color: AppColors.pargColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.find<ProductController>().clearBooking();
                        Get.off(() => const Home());
                      },
                      child: const CustomButton(text: 'Trở về')),
                ],
              ),
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight * .695,
            left: Dimensions.widthPadding15,
            child: const Icon(
              Icons.circle,
              color: AppColors.pargColor,
            ),
          ),
          Positioned(
            top: Dimensions.screenHeight * .695,
            right: Dimensions.widthPadding15,
            child: const Icon(
              Icons.circle,
              color: AppColors.pargColor,
            ),
          ),
        ],
      ),
    );
  }
}
