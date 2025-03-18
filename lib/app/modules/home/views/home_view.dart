import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/modules/home/views/detail_address_view.dart';
import 'package:blueray_cargo/app/widgets/dialog_widget.dart';
import 'package:blueray_cargo/app/widgets/empty_widget.dart';
import 'package:blueray_cargo/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Alamat'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(IconsaxPlusLinear.logout),
            onPressed: () {
              dialogWidget(
                type: 'info',
                message: 'Yakin ingin keluar?',
                textButton: 'Yakin',
                onPressed: () {
                  Get.back();
                  homeC.logout();
                },
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(
            () => DetailAddressView(),
            transition: Transition.downToUp,
            fullscreenDialog: true,
            arguments: 'Tambah',
          );
        },
        label: const Text('Tambah Alamat'),
        icon: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: homeC.getAlamat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingWidget(color: primary));
          }

          return Obx(
            () => homeC.addressData.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: homeC.addressData.length,
                    itemBuilder: (context, index) {
                      final data = homeC.addressData[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: data.isPrimary ?? false
                                ? primary
                                : Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: grey.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(IconsaxPlusBold.home_2),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    data.addressLabel ?? '-',
                                    style: TextStyle(
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                                color: grey, thickness: 0.5, height: 25),
                            Row(
                              children: [
                                Icon(IconsaxPlusBold.profile),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(data.name ?? '-'),
                                ),
                              ],
                            ),
                            const Divider(
                                color: grey, thickness: 0.5, height: 25),
                            Row(
                              children: [
                                Icon(IconsaxPlusBold.call),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(data.phoneNumber ?? '-'),
                                ),
                              ],
                            ),
                            const Divider(
                                color: grey, thickness: 0.5, height: 25),
                            Row(
                              children: [
                                Icon(IconsaxPlusBold.location),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    data.address ?? '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                                color: grey, thickness: 0.5, height: 25),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (data.isPrimary == false) {
                                      homeC.setPrimary(data.addressId!);
                                    }
                                  },
                                  child: Text(
                                    'Jadikan Alamat Utama',
                                    style: TextStyle(
                                      color: data.isPrimary ?? false
                                          ? grey
                                          : primary,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: const Icon(Icons.edit_outlined),
                                  onTap: () {
                                    homeC.editAlamat(data);
                                    Get.to(
                                      () => DetailAddressView(),
                                      transition: Transition.downToUp,
                                      fullscreenDialog: true,
                                      arguments: 'Edit',
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: red,
                                  ),
                                  onTap: () {
                                    dialogWidget(
                                      type: 'info',
                                      message:
                                          'Yakin ingin menghapus alamat ini?',
                                      textButton: 'Yakin',
                                      onPressed: () {
                                        Get.back();
                                        homeC.hapusAlamat(data.addressId!);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: EmptyWidget(),
                  ),
          );
        },
      ),
    );
  }
}
