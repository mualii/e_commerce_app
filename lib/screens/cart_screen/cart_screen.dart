import 'package:e_commerce_app_muhammed_ali/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/cubit/home/home_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/products_model.dart';
import '../../shared/components/defult_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackGround,
        body: Column(
          children: [
            const CustomAppBar(title: "سلة التسوق"),
            SizedBox(height: 16.h),
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is DeleteItemState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    content: Center(child: Text('تم الازالة من المتجر ')),
                  ));
                }
              },
              builder: (context, state) {
                CartCubit.get(context).getTotal();
                return Padding(
                  padding: EdgeInsets.all(17.0.r),
                  child: Column(
                    children: [
                      Container(
                        height: 48.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: CartCubit.get(context)
                                          .countOfItemInCart
                                          .toString(),
                                      style: AppTextStyle.TFFText14,
                                    ),
                                    TextSpan(
                                      text: "عنصر",
                                      style: AppTextStyle.bodeText14,
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "الإجمالي  ",
                                      style: AppTextStyle.TFFText14,
                                    ),
                                    TextSpan(
                                      text:
                                          "جم ${CartCubit.get(context).total.toString()}",
                                      style: AppTextStyle.bodeText14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: .67.sh,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              ProductResults model =
                                  Hive.box("cart").getAt(index);
                              return Container(
                                height: 152.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 111.h,
                                            width: 123.w,
                                            child: Image.network(
                                              model.imageLink.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 8.w),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 188.w,
                                            child: Text(
                                              model.description.toString(),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.subtitel12,
                                            ),
                                          ),
                                          SizedBox(height: 14.h),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: model.price.toString(),
                                                  style: AppTextStyle
                                                      .tajawalMediumText18,
                                                ),
                                                TextSpan(
                                                  text: "ج.م",
                                                  style: AppTextStyle
                                                      .tajawalMediumText18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                    Container(
                                        width: double.infinity,
                                        height: 1.h,
                                        color: Colors.grey),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomButton(
                                            radius: 0.r,
                                            height: 38.h,
                                            width: 38.w,
                                            onTap: () {
                                              CartCubit.get(context)
                                                  .addOneQuantity(model: model);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 24.r,
                                            )),
                                        Container(
                                          width: 50.w,
                                          height: 38.h,
                                          color: Colors.white,
                                          child: Center(
                                              child: Text(
                                            model.quantity.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.headlineText16,
                                          )),
                                        ),
                                        CustomButton(
                                            radius: 0.r,
                                            height: 38.h,
                                            width: 38.w,
                                            onTap: () {
                                              CartCubit.get(context)
                                                  .removeOneQuantity(
                                                      model: model);
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 24.r,
                                            )),
                                        SizedBox(width: .17.sw),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${model.quantity! * double.parse(model.price!)}",
                                                style: AppTextStyle
                                                    .tajawalMediumText18,
                                              ),
                                              TextSpan(
                                                text: "ج.م",
                                                style: AppTextStyle
                                                    .tajawalMediumText18,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                            height: 38,
                                            width: 38,
                                            color: AppColors.colorFav,
                                            child: IconButton(
                                              onPressed: () {
                                                CartCubit.get(context)
                                                    .delete(index: index);
                                                HomeCubit.get(context)
                                                    .removeFromCart(
                                                        id: model.id!);
                                              },
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemCount: Hive.box("cart").length),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ));
  }
}
