import 'package:flutter/material.dart';

import '../../shared/colors_textstyle.dart';
import 'home_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackGround,
        body: const SafeArea(
          child: HomeBody(),
        ));
  }
}
