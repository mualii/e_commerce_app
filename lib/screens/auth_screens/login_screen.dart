import 'package:e_commerce_app_muhammed_ali/cubit/login/login_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/screens/auth_screens/register_screen.dart';
import 'package:e_commerce_app_muhammed_ali/screens/layout_screen/layout_screen.dart';
import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:e_commerce_app_muhammed_ali/shared/components/defult_button.dart';
import 'package:e_commerce_app_muhammed_ali/shared/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/validator.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 54.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/login.png",
                      height: 96.h,
                      width: 130.65.w,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  "تسجيل الدخول",
                  style: AppTextStyle.tajawalBoldText19,
                ),
                SizedBox(height: 12.h),
                Text(
                  "من فضلك قم بالدخول لإتمام الشراء",
                  style: AppTextStyle.bodeText14,
                ),
                SizedBox(height: 52.h),
                Form(
                  key: _formKey,
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LogInErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('اسم المستخدم غير موجود'),
                        ));
                      }
                      if (state is LogInSuccessState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('مرحبا بك'),
                        ));
                        navigateReplacementTo(context, const LayoutScreen());
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormFeild(
                              textEditingController:
                                  LoginCubit.get(context).userNameController,
                              textInputType: TextInputType.name,
                              iconEyeRun: false,
                              titleField: "اسم المستخدم",
                              validator: (String? name) =>
                                  Validator.validateName(name ?? "")),
                          CustomTextFormFeild(
                            textEditingController:
                                LoginCubit.get(context).passwordController,
                            textInputType: TextInputType.text,
                            hideText: true,
                            iconEyeRun: true,
                            titleField: "كلمة السر",
                            validator: (String? password) =>
                                Validator.validatePassword(password ?? ""),
                          ),
                          SizedBox(height: 29.h),
                          state is LogInLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : CustomButton(
                                  radius: 4.r,
                                  height: 40.h,
                                  width: double.infinity,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin();
                                    }
                                  },
                                  child: Text(
                                    "الدخول",
                                    style: AppTextStyle.buttonText16,
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 37.h),
                InkWell(
                  onTap: () {
                    navigateFinish(context, RegisterScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "ليس لديك حساب ؟",
                          style: AppTextStyle.bodeText14,
                        ),
                        TextSpan(
                          text: "التسجيل",
                          style: AppTextStyle.tajawalBoldText18,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
