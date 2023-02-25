import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:e_commerce_app_muhammed_ali/shared/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Function()? onTap;
  final Widget child;

  const CustomButton(
      {super.key,
      required this.radius,
      required this.height,
      required this.width,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class CustomTextFormFeild extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  bool hideText;
  final bool iconEyeRun;
  final String titleField;
  String? Function(String?)? validator;
  void Function()? onEyeTap;

  CustomTextFormFeild(
      {super.key,
      required this.textEditingController,
      required this.textInputType,
      this.hideText = false,
      this.onEyeTap,
      required this.iconEyeRun,
      required this.titleField,
      required this.validator});

  @override
  State<CustomTextFormFeild> createState() => _CustomTextFormFeildState();
}

class _CustomTextFormFeildState extends State<CustomTextFormFeild> {
  bool hideTitle = false;

  Widget? prefixIcon;

  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 3.w,
              ),
              Text(widget.titleField, style: AppTextStyle.bodeText14),
            ],
          ),
          TextFormField(
            style: AppTextStyle.TFFText14,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.textInputType,
            controller: widget.textEditingController,
            obscureText: widget.hideText,
            decoration: InputDecoration(
                fillColor: AppColors.colorButton,
                filled: true,
                counterText: "",
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.colorPrimary,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.colorPrimary,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.colorPrimary,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.colorPrimary,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: AppColors.colorError,
                    )),
                errorStyle: AppTextStyle.errorText12,
                suffixIcon: widget.iconEyeRun
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.hideText = !widget.hideText;
                              });
                            },
                            child: !widget.hideText
                                ? Icon(Icons.visibility_off_sharp,
                                    color: AppColors.colorEye)
                                : Icon(Icons.remove_red_eye,
                                    color: AppColors.colorEye)),
                      )
                    : suffixIcon ?? null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.colorButton,
        height: 56.h,
        width: context.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                color: Colors.grey,
                size: 17.sp,
              ),
              Text(
                title,
                style: AppTextStyle.bodeText14,
              ),
              Icon(
                Icons.search,
                color: Colors.grey,
                size: 17.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
