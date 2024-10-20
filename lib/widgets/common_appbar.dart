
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constant.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? leadingIcon;
  final double? iconSize;
  final double? actionIconSize;
  final double? leadingWidth;
  final String? title;
  final String? titleIcon;
  final TextStyle? titleTextStyle;
  final VoidCallback? leadingOnTap;
  final String Function(String)? onChange;
  final List? actionIcons;
  final VoidCallback? actionOnTap;
  final String? actionIcon;
  final Color? backGroundColor;

  const CommonAppBar({
    Key? key,
    this.leadingIcon,
    this.iconSize,
    this.actionIconSize,
    this.title,
    this.titleIcon,
    this.titleTextStyle,
    this.leadingOnTap,
    this.onChange,
    this.actionIcon,
    this.actionOnTap,
    this.leadingWidth,
    this.actionIcons,
    this.backGroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backGroundColor ?? ColorsConfig.blackColor,
      title: Text(title ?? '',
          style:
          titleTextStyle ??
           TextStyle(fontSize: 24, fontWeight: FontWeight.w500,
          fontFamily: AppTextStyle.robotoBold
      )),
      leading: GestureDetector(
        onTap: leadingOnTap ?? (){
          Get.back();
        },
        child: leadingIcon != null
            ? Image.asset(
          leadingIcon!,
          scale: iconSize ??  25.0,
          color: ColorsConfig.whiteColor,
        )
            : Container(),
      ),
      leadingWidth: leadingWidth,
      actions: [
        GestureDetector(
          onTap: actionOnTap ?? (){
            //Get.back();
          },
          child: actionIcon != null
              ?
          Image.asset( actionIcon!, scale: actionIconSize ??  25.0, color: ColorsConfig.whiteColor,) :Container(),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// import 'package:flutter/material.dart';
// import '../constant/app_constant.dart';
//
//  class CommonAppBar extends StatelessWidget implements PreferredSize{
//   final Color? color;
//   String? title;
//   Widget? leadingIcon;
//   Widget? actionIcon;
//
//   CommonAppBar({
//     super.key,
//     this.color,
//     this.title,
//     this.leadingIcon,
//     this.actionIcon
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//         backgroundColor: color ?? AppConstants.appColor,
//         title: Text(
//           title!,
//         ),
//         actions: [
//           // Image.asset(
//           //   "assets/images/filter@2x.png",
//           //   scale: 8,
//           //   color: AppConstants.whiteColor,
//           // ),
//           actionIcon!,
//         ],
//         leading: InkWell(
//           onTap: () {
//
//             //controller.scaffoldKey.currentState!.openDrawer();
//             //Scaffold.of(context).openDrawer();
//           },
//           child: leadingIcon,
//         ));
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => throw UnimplementedError();
//
//   @override
//   // TODO: implement child
//   Widget get child => throw UnimplementedError();
//
// }
//
