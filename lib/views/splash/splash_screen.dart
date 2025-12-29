import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteflow/core/constants/app_colors.dart';
import 'package:noteflow/core/constants/app_strings.dart';
import 'package:noteflow/core/routes/routes_name.dart';
import 'package:noteflow/core/services/shared_preference/app_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.babyBlue,
        body: Center(
          child: Text(
            AppStrings.exploreNotes,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  void checkLogin() async {
    bool? isLoggedIn = await AppPreference.getLogin();
    print('isLoggedIn: $isLoggedIn');
    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn == null) {
        Get.offAndToNamed(RoutesName.loginScreen);
      } else {
        Get.offAndToNamed(RoutesName.notesScreen2);
      }
    });
  }
}
