import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:blueray_cargo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final loginC = Get.put(LoginController());
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
            'Masuk',
            style: TextStyle(
              fontSize: 28,
              fontWeight: bold,
            ),
          ),
        ),
        Text(
          'Silahkan masuk untuk dapat menggunakan semua fitur\naplikasi Blueray Cargo',
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
              controller: loginC.emailC.value,
              errorText: loginC.emailError.value,
            ),
            const SizedBox(height: 20),
            FormWidget(
              hintText: 'Password',
              obscureText: loginC.isShow.value,
              errorText: loginC.passwordError.value,
              suffixIcon: IconButton(
                onPressed: () => loginC.isShow.toggle(),
                icon: Icon(
                  loginC.isShow.value
                      ? IconsaxPlusLinear.eye
                      : IconsaxPlusLinear.eye_slash,
                  color: black.withOpacity(0.5),
                ),
              ),
              controller: loginC.passwordC.value,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    'Lupa password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),
              ),
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
          Text(
            'Atau masuk menggunakan\nmetode yang lain',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: black.withOpacity(0.1),
                    ),
                  ),
                  child: Image.asset(
                    'assets/google.png',
                    width: 30,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: black.withOpacity(0.1),
                    ),
                  ),
                  child: Image.asset(
                    'assets/apple.png',
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => ButtonWidget(
              title: 'Masuk',
              loading: loginC.isLoading.value,
              onPressed: () {
                if (loginC.isLoading.isFalse) {
                  loginC.login();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tidak memiliki akun?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black.withOpacity(0.5),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Get.offAllNamed('/register'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Daftar sekarang',
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
