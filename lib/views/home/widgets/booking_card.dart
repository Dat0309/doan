import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/models/Product.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/app_icon.dart';
import 'package:doan/widgets/big_text.dart';
import 'package:doan/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingCard extends StatefulWidget {
  final Product product;
  final VoidCallback press;

  const BookingCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return GestureDetector(
        onTap: widget.press,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius20 * 1.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Dimensions.width150 + 40,
                  height: Dimensions.height140 + 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.pargColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.product.image!),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.widthPadding10),
                child: Center(child: BigText(text: widget.product.name)),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.widthPadding10),
                child: Center(
                    child:
                        SmallText(text: '${widget.product.price.toString()}Đ')),
              ),
              GetBuilder<CartController>(builder: (cartontroller) {
                return Center(
                    child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.buttoBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius30 + 10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (qty == 1) {
                            setState(() {
                              qty -= 1;
                            });
                            // bookingController.removeItem(widget.product);
                            productController.removeBookingItem(widget.product);
                          } else if (qty > 0) {
                            setState(() {
                              qty -= 1;
                            });
                            // bookingController.updateItemQty(
                            //     widget.product.id!, qty);
                            productController.updateBookingQty(
                                widget.product.id!, qty);
                          }
                        },
                        child: const AppIcon(
                          icon: Icons.remove,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.radius20),
                        child: SmallText(text: qty.toString()),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (qty == 0) {
                            setState(() {
                              qty += 1;
                            });
                            productController.addBookingItem(
                                widget.product, qty);
                          } else {
                            setState(() {
                              qty += 1;
                            });
                            // bookingController.updateItemQty(
                            //     widget.product.id!, qty);
                            productController.updateBookingQty(
                                widget.product.id!, qty);
                          }
                        },
                        child: const AppIcon(
                          icon: Icons.add,
                        ),
                      ),
                    ],
                  ),
                ));
              })
            ],
          ),
        ),
      );
    });
  }
}
