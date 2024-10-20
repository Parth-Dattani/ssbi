
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';


class CommonButton extends StatelessWidget {
  Color? color;
  final String? name;
  final double? textSize;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Size? buttonSize;
  final double? radius;
  final TextStyle? textStyle;

   CommonButton({super.key,
    this.color,
    required this.name,
     this.textSize,
     this.textColor,
    required this.onPressed,
     this.buttonSize,
     this.radius = 30.0,
     this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          //backgroundColor: const Color(0xff070534),
            backgroundColor: color ?? const Color(0XFF1A60AB),
            fixedSize: buttonSize ?? Size(Get.width * 0.8, Get.height * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
            )
        ),
        onPressed: onPressed,
        child: Text(name!,
          style:
          //textStyle
          TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.w700,
              fontFamily: AppTextStyle.robotoRegular
          ),
        ));
  }
}
