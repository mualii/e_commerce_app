import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static Color colorFav = const Color(0xffFF8E42);
  static Color colorBorder = const Color(0xffD4D4D4);
  static Color colorIcons = const Color(0xff00000073);
  static Color colorEye = const Color(0xff000000);
  static Color colorRate = const Color(0xffFFE621);
  static Color colorPrimary = const Color(0xff0000CE);
  static Color colorText = const Color(0xff032326);

  static Color colorError = const Color(0xffF84711);
  static Color colorBackGround = const Color(0xffF5F5F9);
  static Color colorButton = const Color(0xffFFFFFF);
}

class AppTextStyle {
  static TextStyle TFFText14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      color: AppColors.colorPrimary);
  static TextStyle subtitel12 = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorText);
  static TextStyle bodeText14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorText);
  static TextStyle headlineText16 = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorText);
  static TextStyle tajawalBoldText18 = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      decoration: TextDecoration.underline,
      color: AppColors.colorFav);
  static TextStyle tajawalBoldText19 = TextStyle(
      fontSize: 19.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      color: AppColors.colorFav);
  static TextStyle tajawalBoldFavText14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      color: AppColors.colorFav);
  static TextStyle tajawalBoldText14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      color: AppColors.colorText);
  static TextStyle tajawalMediumText18 = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorPrimary);
  static TextStyle tajawalMediumText14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorPrimary);
  static TextStyle tajawalMediumText12 = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorPrimary);
  static TextStyle errorText12 = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorError);
  static TextStyle buttonText16 = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      fontFamily: "Tajawal",
      color: AppColors.colorButton);
  static TextStyle Headline1Text24pt = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      fontFamily: "Tajawal",
      color: AppColors.colorButton);
}
