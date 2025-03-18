import 'dart:convert';
import 'dart:developer';

import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/modules/profile/views/update_profile_view.dart';
import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:blueray_cargo/app/services/dio_client.dart';
import 'package:blueray_cargo/app/widgets/dialog_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfileController extends GetxController {
  final dio = DioClient();
  var isLoading = false.obs;

  var isShow = true.obs;
  var passwordC = TextEditingController().obs;
  var firstNameC = TextEditingController().obs;
  var firstNameError = ''.obs;
  var lastNameC = TextEditingController().obs;
  var lastNameError = ''.obs;
  var emailC = TextEditingController().obs;
  var emailError = ''.obs;
  var phoneC = TextEditingController().obs;
  var birtday = DateTime.now().obs;
  var gender = 'Laki-laki'.obs;
  var image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailC.value.text = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // buatkan fungsi mengecek password harus lebih dari 8 karakter dan harus mengandung huruf besar, huruf kecil, angka, dan karakter khusus
  void isPasswordValid() {
    final RegExp passwordCheck = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    bool check = passwordCheck.hasMatch(passwordC.value.text);
    if (check == true) {
      Get.to(() => UpdateProfileView());
    } else {
      dialogWidget(
        type: 'error',
        message:
            'Pastikan password anda mengandung huruf besar, huruf kecil, angka, dan karakter khusus',
      );
    }
  }

  Future<void> profilePost() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.MANDATORY,
        data: {
          'user_id': emailC.value.text,
          'first_name': firstNameC.value.text,
          'last_name': lastNameC.value.text,
          'password': passwordC.value.text,
          // 'phone': phoneC.value,
          // 'birthday': birtday.value,
          // 'gender': gender.value,
        },
      );
      Get.offAllNamed('/login');
      Get.snackbar(
        '',
        '',
        titleText: SizedBox(),
        messageText: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Selamat akun berhasil dibuat!',
            style: TextStyle(
              color: white,
              fontWeight: bold,
            ),
          ),
        ),
        backgroundColor: green,
        colorText: white,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        icon: Icon(
          IconsaxPlusLinear.info_circle,
          color: white,
        ),
      );
    } catch (e) {
      var err = jsonDecode(e.toString());
      firstNameError(err['first_name'][0]);
      lastNameError(err['last_name'][0]);
      emailError(err['user_id'][0]);
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadPhoto() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.UPLOAD_IMAGE,
        data: FormData.fromMap(
          {
            'image_file': await MultipartFile.fromFile(
              image.value,
              filename: image.value.split('/').last,
            ),
          },
        ),
      );
    } catch (e, st) {
      dialogWidget(type: 'error', message: e.toString());
      log(e.toString(), stackTrace: st);
    } finally {
      isLoading(false);
    }
  }
}
