import 'package:flutter/material.dart';

import 'constant.dart';

class AppTextStyle {

  ///fonts

  static const montserratRegular = 'Montserrat Regular';
  static const robotoSlabRegular = 'RobotoSlab Regular';
  static const robotoBold = 'Roboto Bold';
  static const robotoRegular = 'Roboto Regular';

  static const textFontSize7 = 7.0;
  static const textFontSize14 = 14.0;
  static const textFontSize18 = 18.0;
  static const textFontSize20 = 20.0;
  static const textFontSize22 = 22.0;
  static const textFontSize24 = 24.0;
  static const textFontSize28 = 28.0;

}

class CustomTextStyle{


  static TextStyle fPText =  TextStyle(
  fontSize: AppTextStyle.textFontSize14,
  fontFamily: AppTextStyle.montserratRegular,
  color: ColorsConfig.whiteColor,
  fontWeight: FontWeight.w200);

  static TextStyle formHeaderText =  TextStyle(
      fontSize: AppTextStyle.textFontSize22,
      fontFamily: AppTextStyle.robotoSlabRegular,
      fontWeight: FontWeight.w300,
      color: ColorsConfig.whiteColor);

  static TextStyle appBarText =  TextStyle(
      fontSize: AppTextStyle.textFontSize24,
      fontFamily: AppTextStyle.robotoRegular,
      fontWeight: FontWeight.w300,
      color: ColorsConfig.whiteColor);


  static TextStyle titleTextStyle =  TextStyle(
      fontSize: AppTextStyle.textFontSize28,
      fontFamily: AppTextStyle.robotoSlabRegular,
      fontWeight: FontWeight.w300,
      color: ColorsConfig.whiteColor);

  static TextStyle btnTextStyle =  TextStyle (
      fontFamily: AppTextStyle.robotoSlabRegular,
      fontWeight: FontWeight.w400,
      fontSize: AppTextStyle.textFontSize22,
      color: ColorsConfig.blackColor
  );

}