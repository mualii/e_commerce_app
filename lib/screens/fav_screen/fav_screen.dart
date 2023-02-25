import 'package:e_commerce_app_muhammed_ali/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/cubit/home/home_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/models/products_model.dart';
import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:e_commerce_app_muhammed_ali/shared/components/defult_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../shared/components/text_info_and_price.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Hive.box("fav").length);
    return Scaffold(
        body: Column(
      children: [
        CustomAppBar(title: "المفضلة"),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Hive.box("fav").length == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: .82.sh,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ProductResults favProd = Hive.box("fav").getAt(index);
                          return Padding(
                            padding: EdgeInsets.all(18.0.h),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: 253.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              favProd.imageLink.toString()),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(17.r),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.favorite,
                                              color: AppColors.colorFav,
                                              size: 24.r,
                                            ),
                                            onPressed: () {
                                              HomeCubit.get(context)
                                                  .putAndRemoveInFavBoxForAllProd(
                                                      index: index,
                                                      id: favProd.id!,
                                                      isFav: true);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextInfoAndPrice(
                                      text: favProd.description.toString(),
                                      price: favProd.price.toString()),
                                  CustomButton(
                                      radius: 4.r,
                                      height: 40.h,
                                      width: double.infinity,
                                      onTap: () {
                                        CartCubit.get(context)
                                            .addToCart(model: favProd);
                                      },
                                      child: Text(
                                        "نقل إلى سلة التسوق",
                                        style: AppTextStyle.buttonText16,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: Hive.box("fav").length),
                  );
          },
        ),
      ],
    ));
  }
}
