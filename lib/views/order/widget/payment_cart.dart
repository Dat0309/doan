import 'package:doan/constants/app_colors.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final Widget widget;
  const PaymentCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.heightPadding20),
      child: Container(
        height: Dimensions.heightPadding30 + 20,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: Dimensions.widthPadding30,
          right: Dimensions.widthPadding20,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            side: BorderSide(
              color: AppColors.pargColor!.withOpacity(0.25),
            ),
          ),
          color: AppColors.buttoBackgroundColor,
        ),
        child: widget,
      ),
    );
  }
}
