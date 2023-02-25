import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors_textstyle.dart';

class TextInfoAndPrice extends StatelessWidget {
  const TextInfoAndPrice({
    super.key,
    required this.text,
    required this.price,
  });
  final String text;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90.h,
            width: double.infinity,
            color: Colors.white,
            child: Text(
              text,
              style: AppTextStyle.headlineText16,
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: AppTextStyle.tajawalMediumText18,
                ),
                TextSpan(
                  text: "ج.م",
                  style: AppTextStyle.tajawalMediumText18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
