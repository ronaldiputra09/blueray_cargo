import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/helpers/image_helper.dart';
import 'package:blueray_cargo/app/modules/home/controllers/home_controller.dart';
import 'package:blueray_cargo/app/modules/home/views/map_view.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:blueray_cargo/app/widgets/form_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DetailAddressView extends GetView {
  DetailAddressView({super.key});
  final homeC = Get.put(HomeController());
  var tipe = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        homeC.clearData();
        return true;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text('$tipe Alamat'),
          centerTitle: true,
        ),
        bottomNavigationBar: footer(),
        body: body(),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          spacing: 10,
          children: [
            FormWidget(
              title: 'Label Alamat',
              hintText: 'Rumah, Kantor, dll',
              required: true,
              controller: homeC.labelC.value,
              errorText: homeC.labelError.value,
            ),
            FormWidget(
              title: 'Nama Penerima',
              hintText: 'Masukkan nama penerima',
              required: true,
              controller: homeC.nameC.value,
              errorText: homeC.nameError.value,
            ),
            FormWidget(
              title: 'Nomor Telepon',
              hintText: 'Masukkan nomor telepon',
              required: true,
              controller: homeC.phoneC.value,
              keyboardType: TextInputType.phone,
              errorText: homeC.phoneError.value,
            ),
            FormWidget(
              title: 'Email',
              hintText: 'Masukkan email',
              controller: homeC.emailC.value,
              keyboardType: TextInputType.emailAddress,
              errorText: homeC.emailError.value,
            ),
            Obx(
              () => FormWidget(
                title: 'Kota atau Kecamatan',
                hintText: 'Pilih kota atau kecamatan',
                controller: TextEditingController(
                  text: homeC.selectLokasi.value.address ?? '',
                ),
                required: true,
                readOnly: true,
                errorText: homeC.provinceError.value,
                suffixIcon: Icon(
                  IconsaxPlusLinear.arrow_down,
                  size: 16,
                ),
                onTap: () {
                  dialogLokasi();
                },
              ),
            ),
            FormWidget(
              title: 'Kode Pos',
              hintText: 'Masukkan kode pos',
              controller: homeC.postalCodeC.value,
              keyboardType: TextInputType.number,
              errorText: homeC.postalCodeError.value,
              required: true,
            ),
            FormWidget(
              title: 'Alamat Lengkap',
              hintText: 'Nama jalan, nomor rumah, dsb',
              required: true,
              maxLine: 3,
              minLine: 3,
              controller: homeC.addressLabelC.value,
              errorText: homeC.addressLabelError.value,
            ),
            FormWidget(
              title: 'Pin Lokasi',
              hintText: 'Pilih pin lokasi',
              controller: TextEditingController(
                text: homeC.map.value,
              ),
              readOnly: true,
              prefixIcon: Icon(
                IconsaxPlusLinear.location,
                size: 16,
              ),
              onTap: () => Get.to(() => MapView()),
            ),
            FormWidget(
              title: 'No NPWP',
              hintText: 'Masukkan no NPWP',
              controller: homeC.npwpC.value,
              keyboardType: TextInputType.number,
            ),
            FormWidget(
              title: 'File NPWP',
              hintText: 'Pilih file NPWP',
              controller: TextEditingController(
                text: homeC.npwpFile.value.split('/').last,
              ),
              readOnly: true,
              prefixIcon: Icon(
                IconsaxPlusLinear.document,
                size: 16,
              ),
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
                                homeC.npwpFile.value = value;
                                homeC.uploadPhoto();
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
                                homeC.npwpFile.value = value;
                                homeC.uploadPhoto();
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
            ),
          ],
        ),
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
          loading: homeC.isLoading.value,
          onPressed: () {
            if (homeC.isLoading.isFalse) {
              if (tipe == 'Tambah') {
                homeC.tambahAlamat();
              } else {
                homeC.updateAlamat();
              }
            }
          },
        ),
      ),
    );
  }

  Future dialogLokasi() {
    return Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: Get.height * 0.4,
        width: Get.width,
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          children: [
            FormWidget(
              hintText: 'Cari Kota atau Kecamatan',
              prefixIcon: Icon(
                IconsaxPlusLinear.search_normal,
              ),
              controller: homeC.searchC.value,
              onEditingComplete: () {
                homeC.getLokasi();
              },
            ),
            Expanded(
              child: Obx(
                () => homeC.lokasiData.isNotEmpty
                    ? ListView.builder(
                        itemCount: homeC.lokasiData.length,
                        itemBuilder: (context, index) {
                          var data = homeC.lokasiData[index];
                          return ListTile(
                            title: Text(
                              data.address ?? "-",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: bold,
                              ),
                            ),
                            subtitle: Text(
                              data.province ?? "-",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              homeC.selectLokasi.value = data;
                              Get.back();
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text('Data tidak ditemukan'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
