import 'dart:io';

import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/helpers/image_helper.dart';
import 'package:blueray_cargo/app/modules/profile/controllers/profile_controller.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:blueray_cargo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

class UpdateProfileView extends GetView {
  UpdateProfileView({super.key});
  final profileC = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Ubah Profil'),
        centerTitle: true,
      ),
      bottomNavigationBar: footer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            avatar(),
            body(),
          ],
        ),
      ),
    );
  }

  Widget avatar() {
    return Stack(
      children: [
        Obx(
          () => profileC.image.value == ''
              ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    IconsaxPlusBold.profile,
                    size: 50,
                    color: black.withOpacity(0.5),
                  ),
                )
              : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(File(profileC.image.value)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Pilih Foto Profil',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: Icon(IconsaxPlusBold.camera),
                        title: Text('Kamera'),
                        onTap: () {
                          Get.back();
                          ImageHelper().picker(isCamera: true).then(
                            (value) {
                              profileC.image.value = value;
                              profileC.uploadPhoto();
                            },
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(IconsaxPlusBold.image),
                        title: Text('Galeri'),
                        onTap: () {
                          Get.back();
                          ImageHelper().picker(isCamera: false).then(
                            (value) {
                              profileC.image.value = value;
                              profileC.uploadPhoto();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                IconsaxPlusBold.camera,
                size: 16,
                color: white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FormWidget(
            title: 'Nama Depan',
            hintText: 'Masukan Nama Depan',
            keyboardType: TextInputType.name,
            required: true,
            controller: profileC.firstNameC.value,
            errorText: profileC.firstNameError.value,
          ),
          const SizedBox(height: 10),
          FormWidget(
            title: 'Nama Belakang',
            hintText: 'Masukan Nama Belakang',
            keyboardType: TextInputType.name,
            required: true,
            controller: profileC.lastNameC.value,
            errorText: profileC.lastNameError.value,
          ),
          const SizedBox(height: 10),
          FormWidget(
            title: 'Email',
            hintText: 'Masukan Email',
            keyboardType: TextInputType.emailAddress,
            readOnly: true,
            controller: profileC.emailC.value,
            errorText: profileC.emailError.value,
          ),
          const SizedBox(height: 10),
          FormWidget(
            title: 'Nomor Telepon',
            hintText: 'Masukan Nomor Telepon',
            keyboardType: TextInputType.phone,
            controller: profileC.phoneC.value,
          ),
          const SizedBox(height: 10),
          Obx(
            () => FormWidget(
              title: 'Tanggal Lahir',
              hintText: 'Pilih Tanggal Lahir',
              keyboardType: TextInputType.streetAddress,
              controller: TextEditingController(
                text: DateFormat('dd/MM/yyyy').format(profileC.birtday.value),
              ),
              readOnly: true,
              suffixIcon: Icon(
                IconsaxPlusLinear.calendar,
                color: black.withOpacity(0.5),
              ),
              onTap: () {
                showDatePicker(
                  context: Get.context!,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: profileC.birtday.value,
                ).then(
                  (value) {
                    if (value != null) {
                      profileC.birtday.value = value;
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jenis Kelamin',
                style: TextStyle(
                  color: black,
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: 'M',
                      groupValue: profileC.gender.value,
                      splashRadius: 0,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) =>
                          profileC.gender.value = value.toString(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Laki-laki',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => Radio(
                      value: 'F',
                      groupValue: profileC.gender.value,
                      splashRadius: 0,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) =>
                          profileC.gender.value = value.toString(),
                    ),
                  ),
                  Text(
                    'Perempuan',
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => ButtonWidget(
          title: 'Simpan',
          loading: profileC.isLoading.value,
          onPressed: () {
            if (profileC.isLoading.isFalse) {
              profileC.profilePost();
            }
          },
        ),
      ),
    );
  }
}
