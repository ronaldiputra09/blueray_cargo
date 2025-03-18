import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:blueray_cargo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});
  final registerC = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            body(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          bottom: false,
          child: Text(
            'Daftar',
            style: TextStyle(
              fontSize: 28,
              fontWeight: bold,
            ),
          ),
        ),
        Text(
          'Silahkan daftar untuk dapat menggunakan semua fitur\naplikasi Blueray Cargo',
          style: TextStyle(
            color: black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Obx(
        () => Column(
          children: [
            FormWidget(
              hintText: 'Masukan email atau nomor telepon',
              keyboardType: TextInputType.emailAddress,
              controller: registerC.emailC.value,
              errorText: registerC.emailError.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget footer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Obx(
            () => ButtonWidget(
              title: 'Daftar',
              loading: registerC.isLoading.value,
              onPressed: () {
                if (registerC.isLoading.isFalse) {
                  registerC.register();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sudah memiliki akun?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black.withOpacity(0.5),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Get.offAllNamed('/login'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Masuk sekarang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
