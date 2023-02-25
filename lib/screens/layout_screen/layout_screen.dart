import 'package:e_commerce_app_muhammed_ali/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/screens/cart_screen/cart_screen.dart';
import 'package:e_commerce_app_muhammed_ali/screens/cat_screen/cat_screen.dart';
import 'package:e_commerce_app_muhammed_ali/screens/fav_screen/fav_screen.dart';
import 'package:e_commerce_app_muhammed_ali/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app_muhammed_ali/screens/profile_screen/profile_screen.dart';
import 'package:e_commerce_app_muhammed_ali/shared/colors_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  int currentTap = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
          floatingActionButton: CartCubit.get(context).countOfItemInCart == 0
              ? SizedBox.shrink()
              : FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        CartCubit.get(context).countOfItemInCart.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      currentScreen = CartScreen();
                      currentTap = 2;
                    });
                  },
                ),
          floatingActionButtonLocation:
              CartCubit.get(context).countOfItemInCart != 0
                  ? FloatingActionButtonLocation.centerDocked
                  : null,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: Container(
              height: 60.h,
              child: Row(
                mainAxisAlignment: CartCubit.get(context).countOfItemInCart == 0
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = HomeScreen();
                            currentTap = 0;
                          });
                        },
                        minWidth: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentTap == 0
                                  ? AppColors.colorPrimary
                                  : Colors.grey,
                            ),
                            Text(
                              "home",
                              style: TextStyle(
                                color: currentTap == 0
                                    ? AppColors.colorPrimary
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = CategoryScreen();
                            currentTap = 1;
                          });
                        },
                        minWidth: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              color: currentTap == 1
                                  ? AppColors.colorPrimary
                                  : Colors.grey,
                            ),
                            Text(
                              "category",
                              style: TextStyle(
                                color: currentTap == 1
                                    ? AppColors.colorPrimary
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = FavScreen();
                            currentTap = 3;
                          });
                        },
                        minWidth: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: currentTap == 3
                                  ? AppColors.colorPrimary
                                  : Colors.grey,
                            ),
                            Text(
                              "favorite",
                              style: TextStyle(
                                color: currentTap == 3
                                    ? AppColors.colorPrimary
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = ProfileScreen();
                            currentTap = 4;
                          });
                        },
                        minWidth: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: currentTap == 4
                                  ? AppColors.colorPrimary
                                  : Colors.grey,
                            ),
                            Text(
                              "person",
                              style: TextStyle(
                                color: currentTap == 4
                                    ? AppColors.colorPrimary
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
