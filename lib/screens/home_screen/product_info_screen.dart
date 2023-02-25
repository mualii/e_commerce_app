import 'package:e_commerce_app_muhammed_ali/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/cubit/home/home_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/shared/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/products_model.dart';
import '../../shared/colors_textstyle.dart';
import '../../shared/components/defult_button.dart';

class ProductsInfoScreen extends StatelessWidget {
  const ProductsInfoScreen({Key? key, required this.model, required this.index})
      : super(key: key);
  final ProductResults model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 320.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(model.imageLink.toString()),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.all(17.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 24.r,
                        ),
                        onPressed: () {
                          navigateBack(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HomeCubit.get(context).putAndRemoveInFavBoxForAllProd(
                      index: index, isFav: model.isFav!, id: model.id!);
                },
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (model.isFav == true)
                        Row(
                          children: [
                            SizedBox(width: 25.w),
                            Icon(
                              Icons.favorite,
                              size: 24.r,
                              color: AppColors.colorFav,
                            ),
                            SizedBox(width: 10.w),
                            Text("مضاف للمفضلة",
                                style: AppTextStyle.tajawalBoldFavText14),
                          ],
                        ),
                      if (model.isFav == false)
                        Row(
                          children: [
                            SizedBox(width: 25.w),
                            Icon(
                              Icons.favorite,
                              size: 24.r,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10.w),
                            Text("اضاف للمفضلة",
                                style: AppTextStyle.bodeText14),
                          ],
                        ),
                      Container(
                        color: Colors.grey,
                        width: 4.w,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 24.r,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10.w),
                          Text("مشاركة المنتج", style: AppTextStyle.bodeText14),
                          SizedBox(width: 25.w),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(17.0.r),
                child: Column(
                  children: [
                    Text("",
                        style: AppTextStyle.headlineText16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: model.price.toString(),
                                style: AppTextStyle.tajawalMediumText18,
                              ),
                              TextSpan(
                                text: "ج.م",
                                style: AppTextStyle.tajawalMediumText14,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              model.rate.toString(),
                              style: AppTextStyle.bodeText14,
                            ),
                            Icon(
                              Icons.star,
                              size: 18.sp,
                              color: AppColors.colorRate,
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الوصف",
                          style: AppTextStyle.headlineText16,
                        ),
                        Icon(Icons.arrow_drop_down,
                            color: Colors.grey, size: 24.r)
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 159.w,
                          height: 44.h,
                          child: Row(
                            children: [
                              CustomButton(
                                  radius: 15.r,
                                  height: 44.h,
                                  width: 45.w,
                                  onTap: () {
                                    HomeCubit.get(context).addOneQuantity(
                                        index: index,
                                        price: double.parse(
                                            model.price.toString()));
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24.r,
                                  )),
                              Container(
                                width: 69.w,
                                height: 44.h,
                                color: Colors.white,
                                child: Center(
                                    child: Text(
                                  HomeCubit.get(context).quantity.toString(),
                                  style: AppTextStyle.headlineText16,
                                )),
                              ),
                              CustomButton(
                                  radius: 15.r,
                                  height: 44.h,
                                  width: 45.w,
                                  onTap: () {
                                    HomeCubit.get(context).removeOneQuantity(
                                        index: index,
                                        price: double.parse(
                                            model.price.toString()));
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 24.r,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: 159.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: HomeCubit.get(context).amunt == 0
                                        ? model.price.toString()
                                        : HomeCubit.get(context)
                                            .amunt
                                            .toString(),
                                    style: AppTextStyle.headlineText16,
                                  ),
                                  TextSpan(
                                    text: "ج.م",
                                    style: AppTextStyle.headlineText16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    SizedBox(height: 30.h),
                    CustomButton(
                        radius: 4.r,
                        height: 44.h,
                        width: 158.h,
                        onTap: () {
                          CartCubit.get(context).addToCart(model: model);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Center(child: Text('اضافت الي المتجر ')),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                                size: 20.r,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "أضف للسلة",
                                style: AppTextStyle.buttonText16,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
