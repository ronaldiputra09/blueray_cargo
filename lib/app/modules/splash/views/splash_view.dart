import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});
  final splashC = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Selamat Datang',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
