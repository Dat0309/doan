import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/order_controller.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/home/widgets/booking_card.dart';
import 'package:doan/views/home/widgets/cart_short_view.dart';
import 'package:doan/views/order/detail_order_screen.dart';
import 'package:doan/views/profile/profile.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ProductController>().clearBooking();
  }

  @override
  Widget build(BuildContext context) {
    void createBooking(OrderController orderController) {
      orderController
          .createOrder(
        Get.find<ProductController>().getBookingItems,
        Get.find<UserController>().getPhoneNumber,
        Get.find<ProductController>().bookingTotalPrice,
      )
          .then((value) {
        if (value['status']) {
          Get.to(() => DetailBookingScreen(
                bookingResult: value['order'],
                userOrder: value['updatedUser'],
              ));
        } else {
          Get.snackbar(
            'Không ổn rồi',
            'Đã có lỗi sảy ra trong quá trình thanh toán. Vui lòng kiểm tra lại thông tin!',
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
          );
        }
      });
    }

    Get.find<UserController>().getProfile();
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        return GetBuilder<ProductController>(builder: (productController) {
          return Stack(
            children: [
              Positioned(
                top: Dimensions.heightPadding45,
                left: Dimensions.widthPadding20,
                right: Dimensions.widthPadding20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: Dimensions.heightPadding60 + 10,
                      width: Dimensions.widthPadding60,
                      fit: BoxFit.cover,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: Container(
                        width: Dimensions.widthPadding60 + 10,
                        height: Dimensions.heightPadding60,
                        padding: EdgeInsets.all(Dimensions.widthPadding15),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.primaryColor,
                          image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/profile.jpg',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Dimensions.height120,
                child: Container(
                  width: Dimensions.screenWidth,
                  height: Dimensions.height350 + 280,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.radius20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius20 * 1.5),
                      bottomRight: Radius.circular(Dimensions.radius20 * 1.5),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: productController.isLoaded
                          ? GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  productController.popularProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: Dimensions.widthPadding20,
                                crossAxisSpacing: Dimensions.widthPadding20,
                              ),
                              itemBuilder: (context, index) => BookingCard(
                                    product: productController
                                        .popularProducts[index],
                                    press: () {},
                                  ))
                          : const SizedBox(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Dimensions.widthPadding60 + 20,
                left: Dimensions.widthPadding20,
                right: Dimensions.widthPadding20,
                child: const CardShordView(),
              ),
              Positioned(
                bottom: 0,
                left: Dimensions.widthPadding20,
                right: Dimensions.widthPadding20,
                child: GestureDetector(
                  onTap: () {
                    createBooking(orderController);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimensions.widthPadding10),
                    alignment: Alignment.center,
                    height: Dimensions.heightPadding60,
                    decoration: BoxDecoration(
                      color: AppColors.thirthColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: const BigText(text: 'Thanh toán'),
                  ),
                ),
              )
            ],
          );
        });
      }),
    );
  }
}
