import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:blueray_cargo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final profileC = Get.put(ProfileController());
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          IconsaxPlusLinear.tick_circle,
          size: 100,
          color: green,
        ),
        const SizedBox(height: 10),
        Text(
          'Verifikasi Berhasil',
          style: TextStyle(
            fontSize: 28,
            fontWeight: bold,
          ),
        ),
        Text(
          'Akun anda telah berhasil diverifikasi, silahkan masukan password baru untuk melanjutkan',
          textAlign: TextAlign.center,
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
      child: Column(
        children: [
          Obx(
            () => FormWidget(
              hintText: 'Masukan password',
              obscureText: profileC.isShow.value,
              suffixIcon: IconButton(
                onPressed: () => profileC.isShow.toggle(),
                icon: Icon(
                  profileC.isShow.value
                      ? IconsaxPlusLinear.eye
                      : IconsaxPlusLinear.eye_slash,
                  color: black.withOpacity(0.5),
                ),
              ),
              controller: profileC.passwordC.value,
            ),
          ),
          Text(
            'Password minimal 8 karakter dan harus mengandung huruf besar, huruf kecil, angka dan simbol',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 12,
              color: red,
            ),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ButtonWidget(
            title: 'Selanjutnya',
            onPressed: () {
              profileC.isPasswordValid();
            },
          ),
        ],
      ),
    );
  }
}
