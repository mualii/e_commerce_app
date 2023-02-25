import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app_muhammed_ali/screens/home_screen/product_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/home/home_cubit.dart';
import '../../models/categories_model.dart';
import '../../models/products_model.dart';
import '../../shared/colors_textstyle.dart';
import '../../shared/nav.dart';

class CastAppBar extends StatefulWidget {
  const CastAppBar({
    super.key,
  });

  @override
  State<CastAppBar> createState() => _CastAppBarState();
}

class _CastAppBarState extends State<CastAppBar> {
  int activeIndex = 0;
  final List imageSlider = ["assets/images/ADD.png", "assets/images/cmen.png"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200.h,
          child: Image.asset(
            imageSlider[activeIndex],
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.08),
          ),
        ),
        Column(
          children: [
            SizedBox(
                height: 40.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.list_rounded,
                        color: Colors.grey,
                      ),
                      Text(
                        "الرئيسية",
                        style: AppTextStyle.bodeText14,
                      ),
                      const Icon(
                        Icons.list_rounded,
                        color: Colors.transparent,
                      ),
                    ])),
            Container(
              height: 38.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.colorButton,
                borderRadius: BorderRadius.circular(27.r),
              ),
              child: Row(children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                SizedBox(width: 10.w),
                Text(
                  "عم تبحث ؟",
                  style: AppTextStyle.subtitel12,
                ),
              ]),
            ),
            CarouselSlider.builder(
              options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
              itemCount: imageSlider.length,
              itemBuilder: (context, index, realIndex) {
                final image = imageSlider[index];
                return BuildImage(image, index);
              },
            ),
            buildIndicator(activeIndex, imageSlider)
          ],
        ),
      ],
    );
  }
}

Widget buildIndicator(int activeIndex, List imageSlider) =>
    AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: imageSlider.length,
      effect: JumpingDotEffect(dotHeight: 2.h, dotWidth: 20.w),
    );

Widget BuildImage(image, int index) {
  return Container(
    width: double.infinity,
    height: 140.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
    child: Image.asset(image),
  );
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CastAppBar(),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is FavState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
                content: Text('تم وضع في المفضلة'),
              ));
            }
            if (state is RemoveFavState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
                content: Text('تم اذالة من المفضلة'),
              ));
            }
          },
          builder: (context, state) {
            var categoriesModel = HomeCubit.get(context).categoriesModel;
            var productModel = HomeCubit.get(context).productsModel;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  SizedBox(
                    height: 85.h,
                    child: state is ProductSuccessState ||
                            categoriesModel.results != null
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) =>
                                ListViewBody(
                                    model: categoriesModel.results![index]),
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                                      width: 8.w,
                                    ),
                            itemCount: categoriesModel.results!.length)
                        : const Center(
                            child: CircularProgressIndicator.adaptive()),
                  ),
                  SizedBox(height: 34.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "وصل حديثا",
                        style: AppTextStyle.tajawalBoldText14,
                      ),
                      Text(
                        "عرض الكل",
                        style: AppTextStyle.subtitel12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 205.h,
                    child: state is ProductSuccessState ||
                            productModel.results != null
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) =>
                                ItemListViewBody(
                                    model: productModel.results![index],
                                    index: index),
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                                      width: 8.w,
                                    ),
                            itemCount: productModel.results!.length)
                        : const Center(
                            child: CircularProgressIndicator.adaptive()),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemListViewBody extends StatelessWidget {
  const ItemListViewBody({
    super.key,
    required this.model,
    required this.index,
  });
  final int index;
  final ProductResults model;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 205.h,
      width: 133.w,
      child: Column(
        children: [
          Container(
            height: 115.h,
            width: 133.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  model.imageLink.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    HomeCubit.get(context).putAndRemoveInFavBoxForAllProd(
                        index: index, isFav: model.isFav!, id: model.id!);
                  },
                  child: model.isFav == false
                      ? Icon(
                          Icons.favorite_border,
                          size: 20.r,
                          color: Colors.grey,
                        )
                      : Icon(Icons.favorite,
                          size: 20.r, color: AppColors.colorFav),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 42.h,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    model.description.toString(),
                    maxLines: 2,
                    style: AppTextStyle.subtitel12,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: model.price.toString(),
                            style: AppTextStyle.tajawalMediumText14,
                          ),
                          TextSpan(
                            text: "ج.م",
                            style: AppTextStyle.tajawalMediumText12,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // HomeCubit.get(context)
                        //     .getProductsByIdImpl(id: model.id.toString());
                        navigateTo(
                            context,
                            ProductsInfoScreen(
                              model: model,
                              index: index,
                            ));
                      },
                      child: const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.grey,
                        size: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewBody extends StatelessWidget {
  const ListViewBody({super.key, required this.model});

  final CategoriesResults model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            model.imageLink.toString(),
          ),
          radius: 34.r,
        ),
        Text(
          model.name.toString(),
          style: AppTextStyle.subtitel12,
        )
      ],
    );
  }
}
