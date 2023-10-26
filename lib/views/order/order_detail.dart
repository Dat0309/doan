import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/views/home/home.dart';
import 'package:doan/views/login/widgets/button.dart';
import 'package:doan/widgets/app_icon.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:doan/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatefulWidget {
  final dynamic order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pargColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.height140,
              left: Dimensions.widthPadding30,
              right: Dimensions.widthPadding30,
              bottom: Dimensions.widthPadding30,
            ),
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
                    ),
                    child: BigText(
                        text:
                            'Khách hàng: ${Get.find<UserController>().getName}'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: Dimensions.heightPadding10,
                    ),
                    child: SmallText(
                        text: 'Liên lạc: ${widget.order.phoneNumber}'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: Dimensions.heightPadding10,
                    ),
                    child: SmallText(
                      text:
                          '${widget.order.shippingAddress.address.street}, ${widget.order.shippingAddress.address.ward}, ${widget.order.shippingAddress.address.district}, ${widget.order.shippingAddress.address.province}',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.radius15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const BigText(text: 'Ngày'),
                            SmallText(
                                text: widget.order.createAt
                                    .toString()
                                    .split('T')[0]),
                          ],
                        ),
                        Column(
                          children: [
                            const BigText(text: 'Giao'),
                            SmallText(
                              text: widget.order.isDelivered
                                  ? 'Đã giao'
                                  : 'Chưa giao',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.radius15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const BigText(text: 'Thanh toán'),
                            SmallText(
                              text: widget.order.isPaid
                                  ? 'Đã Thanh toán'
                                  : 'Chưa Thanh toán',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const BigText(text: 'Thành tiền'),
                            SmallText(
                                text: '${widget.order.totalPrice.toString()} Đ')
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 0, bottom: Dimensions.heightPadding10),
                    child: const BigText(
                      text: 'Danh sách món ăn:',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.heightPadding45,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.order.orderItems!.length,
                        itemBuilder: (context, indexItem) {
                          return Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.widthPadding20 / 2),
                            child: Hero(
                              tag:
                                  widget.order.orderItems![indexItem].product! +
                                      "_orderTag",
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      widget
                                          .order.orderItems![indexItem].image!,
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
                                      text: widget
                                          .order.orderItems![indexItem].qty!
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
                        Get.off(() => const Home());
                      },
                      child: const CustomButton(text: 'Trở về')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
