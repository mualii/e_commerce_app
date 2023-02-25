import 'package:e_commerce_app_muhammed_ali/cubit/register/register_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/shared/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/colors_textstyle.dart';
import '../../shared/components/defult_button.dart';
import '../../shared/validator.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
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
                      //
                      "assets/images/Group 247.png",
                      height: 96.h,
                      width: 130.65.w,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  "حساب جديد",
                  style: AppTextStyle.tajawalBoldText19,
                ),
                SizedBox(height: 12.h),
                Text(
                  "مرحبا بك ، قم بملأ البيانات للتسجيل",
                  style: AppTextStyle.bodeText14,
                ),
                SizedBox(height: 52.h),
                Form(
                  key: _formKey,
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content:
                              Text('من فضلك قم بتسجيل الدخول لاكمال العملية'),
                        ));
                      }
                      if (state is RegisterErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('يرجي مراجهة البيانات'),
                        ));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormFeild(
                              textEditingController:
                                  RegisterCubit.get(context).eMailController,
                              textInputType: TextInputType.emailAddress,
                              iconEyeRun: false,
                              titleField: "اسم المستخدم",
                              validator: (String? name) =>
                                  Validator.validateName(name ?? "")),
                          CustomTextFormFeild(
                              textEditingController:
                                  RegisterCubit.get(context).fNameController,
                              textInputType: TextInputType.name,
                              iconEyeRun: false,
                              titleField: "البريد الالكتروني",
                              validator: (String? name) =>
                                  Validator.validateName(name ?? "")),
                          CustomTextFormFeild(
                              textEditingController:
                                  RegisterCubit.get(context).lNameController,
                              textInputType: TextInputType.name,
                              iconEyeRun: false,
                              titleField: "الاسم الأول",
                              validator: (String? name) =>
                                  Validator.validateName(name ?? "")),
                          CustomTextFormFeild(
                              textEditingController:
                                  RegisterCubit.get(context).userNameController,
                              textInputType: TextInputType.name,
                              iconEyeRun: false,
                              titleField: "الاسم الأخيرالاسم الأخير",
                              validator: (String? name) =>
                                  Validator.validateName(name ?? "")),
                          CustomTextFormFeild(
                            textEditingController:
                                RegisterCubit.get(context).passwordController,
                            textInputType: TextInputType.text,
                            hideText: true,
                            iconEyeRun: true,
                            titleField: "كلمة السر",
                            validator: (String? password) =>
                                Validator.validatePassword(password ?? ""),
                          ),
                          CustomTextFormFeild(
                            textEditingController: RegisterCubit.get(context)
                                .confirmPasswordController,
                            textInputType: TextInputType.text,
                            hideText: true,
                            iconEyeRun: true,
                            titleField: "تأكيد كلمة السر",
                            validator: (String? password) =>
                                Validator.validateConfirmPassword(
                                    password ?? "",
                                    RegisterCubit.get(context)
                                        .passwordController
                                        .text),
                          ),
                          SizedBox(height: 29.h),
                          state is RegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : CustomButton(
                                  radius: 4.r,
                                  height: 40.h,
                                  width: double.infinity,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister();
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
                GestureDetector(
                  onTap: () {
                    navigateFinish(context, LoginScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "لديك حساب ؟",
                          style: AppTextStyle.bodeText14,
                        ),
                        TextSpan(
                          text: "الدخول",
                          style: AppTextStyle.tajawalBoldText18,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 86.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
