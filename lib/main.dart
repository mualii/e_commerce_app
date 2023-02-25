import 'package:e_commerce_app_muhammed_ali/cubit/categories/categories_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/cubit/home/home_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/cubit/register/register_cubit.dart';
import 'package:e_commerce_app_muhammed_ali/local_storage/shared_preferences_manager.dart';
import 'package:e_commerce_app_muhammed_ali/screens/layout_screen/layout_screen.dart';
import 'package:e_commerce_app_muhammed_ali/shared/bloc_observer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'cubit/cart/cart_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'models/products_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await PrefsManager.init();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ProductResultsAdapter());
  final favBox = await Hive.openBox("fav");
  final cartBox = await Hive.openBox("cart");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: "assets/translations",
      startLocale: const Locale("ar"),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
          BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
          BlocProvider<CartCubit>(create: (context) => CartCubit()..getTotal()),
          BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()..getCategoriesImpl()),
          BlocProvider<CategoriesCubit>(
              create: (context) => CategoriesCubit()..getCategoriesImpl()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(392.72727272727275, 783.2727272727273),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.orange,
                  fontFamily: "Tajawal",
                ),
                // home: LoginScreen(),
                home: LayoutScreen(),
                // home: CartScreen(),
              );
            }));
  }
}
