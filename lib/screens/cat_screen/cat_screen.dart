import 'package:e_commerce_app_muhammed_ali/models/categories_model.dart';
import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:e_commerce_app_muhammed_ali/shared/components/defult_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/categories/categories_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomAppBar(title: "التصنيفات"),
        Padding(
          padding: EdgeInsets.all(15.0.r),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              var model = CategoriesCubit.get(context).categoriesModel.results;
              return state is GetCategoriesSuccessState
                  ? SizedBox(
                      height: .7825.sh,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              ListViewBodyOfCategories(
                                model: model[index],
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: model!.length),
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            },
          ),
        )
      ],
    ));
  }
}

class ListViewBodyOfCategories extends StatelessWidget {
  final CategoriesResults model;

  const ListViewBodyOfCategories({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(model.imageLink.toString()),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15.r)),
      height: 122.h,
      width: double.infinity,
      child: Center(
        child: Text(
          model.name.toString(),
          style: AppTextStyle.Headline1Text24pt,
        ),
      ),
    );
  }
}
