import 'dart:convert';
import 'dart:developer';

import 'package:blueray_cargo/app/models/alamat_model.dart';
import 'package:blueray_cargo/app/models/lokasi_model.dart';
import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:blueray_cargo/app/services/dio_client.dart';
import 'package:blueray_cargo/app/widgets/dialog_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final dio = DioClient();
  final box = GetStorage();

  GoogleMapController? mapController;

  var isLoading = false.obs;
  var isLoadingMap = false.obs;

  // data alamat
  var addressData = <AlamatModel>[].obs;

  var idAlamat = ''.obs;

  var labelC = TextEditingController().obs;
  var labelError = ''.obs;
  var nameC = TextEditingController().obs;
  var nameError = ''.obs;
  var phoneC = TextEditingController().obs;
  var phoneError = ''.obs;
  var emailC = TextEditingController().obs;
  var emailError = ''.obs;
  var postalCodeC = TextEditingController().obs;
  var postalCodeError = ''.obs;
  var addressLabelC = TextEditingController().obs;
  var addressLabelError = ''.obs;
  var npwpC = TextEditingController().obs;
  var npwpFile = ''.obs;

  var lat = ''.obs;
  var long = ''.obs;
  var map = ''.obs;
  var provinceError = ''.obs;

  // lokasi
  var searchC = TextEditingController().obs;
  var lokasiData = <LokasiModel>[].obs;
  var selectLokasi = LokasiModel().obs;

  @override
  void onInit() {
    super.onInit();
    getLocationCurrent();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getLokasi() async {
    try {
      isLoading.value = true;
      var res = await dio.get(
        ApiPath.LOKASI,
        queryParameters: {
          'q': searchC.value.text,
        },
      );
      var data = res.data;
      lokasiData.value = LokasiModel.fromJsonList(data['data']);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getAlamat() async {
    try {
      final res = await dio.get(
        ApiPath.ADDRESS,
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
      );
      var data = res.data;
      var filter = AlamatModel.fromJsonList(data);
      // filter data jika isPrimary true pindahkan ke index pertama
      var primary = filter.where((e) => e.isPrimary == true).toList();
      var notPrimary = filter.where((e) => e.isPrimary == false).toList();
      addressData.value = primary + notPrimary;
    } catch (e) {
      log(e.toString());
      addressData.clear();
    }
  }

  Future<void> hapusAlamat(int id) async {
    try {
      await dio.delete(
        ApiPath.DELETE_ADDRESS,
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
        data: {
          'address_id': id,
        },
      );
      getAlamat();
      dialogWidget(
        type: 'success',
        message: 'Berhasil menghapus alamat!',
        onPressed: () {
          Get.back();
        },
      );
    } catch (e) {
      dialogWidget(type: 'error', message: e.toString());
    }
  }

  Future<void> tambahAlamat() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.ADDRESS,
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
        data: {
          'address': addressLabelC.value.text,
          'name': nameC.value.text,
          'phone_number': phoneC.value.text,
          'email': emailC.value.text,
          'address_label': labelC.value.text,
          'province_id': selectLokasi.value.provinceId,
          'district_id': selectLokasi.value.districtId,
          'sub_district_id': selectLokasi.value.subDistrictId,
          'postal_code': postalCodeC.value.text,
          'lat': double.parse(lat.value),
          'long': double.parse(long.value),
          'address_map': map.value,
          'npwp': npwpC.value.text,
          'npwp_file': npwpFile.value,
        },
      );
      getAlamat();
      dialogWidget(
        type: 'success',
        message: 'Berhasil menambahkan alamat baru!',
        onPressed: () {
          Get.back();
          Get.back();
          clearData();
        },
      );
    } catch (e) {
      var error = jsonDecode(e.toString());
      nameError.value = error['name'][0] ?? '';
      phoneError.value = error['phone_number'][0] ?? '';
      provinceError.value = error['province_id'][0] ?? '';
      postalCodeError.value = error['postal_code'][0] ?? '';
      addressLabelError.value = error['address'][0] ?? '';
    } finally {
      isLoading(false);
    }
  }

  Future<void> editAlamat(AlamatModel data) async {
    idAlamat.value = data.addressId.toString();
    addressLabelC.value.text = data.address ?? '';
    nameC.value.text = data.name ?? '';
    phoneC.value.text = data.phoneNumber ?? '';
    emailC.value.text = data.email ?? '';
    postalCodeC.value.text = data.postalCode ?? '';
    labelC.value.text = data.addressLabel ?? '';
    selectLokasi.value = LokasiModel(
      provinceId: data.provinceId,
      districtId: data.districtId,
      subDistrictId: data.subDistrictId,
      province: data.provinceName ?? '',
      district: data.districtName ?? '',
      subDistrict: data.subDistrictName ?? '',
      address: data.address ?? '',
    );
    lat.value = data.lat.toString();
    long.value = data.long.toString();
    map.value = data.addressMap ?? '';
    npwpC.value.text = data.npwp ?? '';
    npwpFile.value = data.npwpFile ?? '';
  }

  Future<void> updateAlamat() async {
    isLoading(true);
    try {
      await dio.put(
        '${ApiPath.ADDRESS}/$idAlamat',
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
        data: {
          'address': addressLabelC.value.text,
          'name': nameC.value.text,
          'phone_number': phoneC.value.text,
          'email': emailC.value.text,
          'address_label': labelC.value.text,
          'province_id': selectLokasi.value.provinceId,
          'district_id': selectLokasi.value.districtId,
          'sub_district_id': selectLokasi.value.subDistrictId,
          'postal_code': postalCodeC.value.text,
          'lat': double.parse(lat.value),
          'long': double.parse(long.value),
          'address_map': map.value,
          'npwp': npwpC.value.text,
          'npwp_file': npwpFile.value,
        },
      );
      getAlamat();
      dialogWidget(
        type: 'success',
        message: 'Berhasil mengubah alamat!',
        onPressed: () {
          Get.back();
          Get.back();
          clearData();
        },
      );
    } catch (e) {
      var error = jsonDecode(e.toString());
      nameError.value = error['name'][0] ?? '';
      phoneError.value = error['phone_number'][0] ?? '';
      provinceError.value = error['province_id'][0] ?? '';
      postalCodeError.value = error['postal_code'][0] ?? '';
      addressLabelError.value = error['address'][0] ?? '';
    } finally {
      isLoading(false);
    }
  }

  Future<void> setPrimary(int id) async {
    try {
      await dio.post(
        ApiPath.PRIMARY_SET,
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
        data: {
          'address_id': id,
        },
      );
      getAlamat();
      dialogWidget(
        type: 'success',
        message: 'Berhasil mengatur alamat utama!',
        onPressed: () {
          Get.back();
        },
      );
    } catch (e) {
      dialogWidget(type: 'error', message: e.toString());
    }
  }

  Future<void> uploadPhoto() async {
    isLoading(true);
    try {
      var res = await dio.post(
        ApiPath.UPLOAD_FILE,
        data: FormData.fromMap(
          {
            'file_data': await MultipartFile.fromFile(
              npwpFile.value,
              filename: npwpFile.value.split('/').last,
            ),
          },
        ),
      );
      npwpFile.value = res.data['file_url'];
    } catch (e, st) {
      dialogWidget(type: 'error', message: e.toString());
      log(e.toString(), stackTrace: st);
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await dio.post(
        ApiPath.LOGOUT,
        options: Options(headers: {
          'Authorization': 'Token ${box.read("token")}',
        }),
      );
      box.remove('token');
      Get.offAllNamed('/login');
    } catch (e) {
      dialogWidget(type: 'error', message: e.toString());
    }
  }

  Future getNamePlace() async {
    var location = await placemarkFromCoordinates(
      double.parse(lat.value),
      double.parse(long.value),
    );
    var place = location.first;
    map.value =
        '${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea}';
  }

  void clearData() {
    idAlamat.value = '';
    labelC.value.clear();
    nameC.value.clear();
    phoneC.value.clear();
    emailC.value.clear();
    postalCodeC.value.clear();
    addressLabelC.value.clear();
    map.value = '';
    searchC.value.clear();
    lokasiData.clear();
    selectLokasi.value = LokasiModel();
    npwpC.value.clear();
    npwpFile.value = '';

    labelError.value = '';
    nameError.value = '';
    phoneError.value = '';
    emailError.value = '';
    postalCodeError.value = '';
    addressLabelError.value = '';
    provinceError.value = '';

    getLocationCurrent();
  }

  void getLocationCurrent() async {
    isLoadingMap.value = true;
    try {
      var enableLocation = await Geolocator.isLocationServiceEnabled();
      var permission = await Geolocator.checkPermission();
      if (!enableLocation) {
        return dialogWidget(
          type: 'error',
          message: "Mohon aktifkan lokasi anda. Tekan tombol dibawah ini.",
          onPressed: () {
            Get.back();
            Get.back();
            Geolocator.openLocationSettings();
          },
        );
        // return;
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return dialogWidget(
            type: 'error',
            message:
                "Mohon izinkan aplikasi untuk mengakses lokasi anda. Tekan tombol dibawah ini.",
            onPressed: () {
              Get.back();
              Get.back();
              Geolocator.openAppSettings();
            },
          );
          // return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      lat.value = position.latitude.toString();
      long.value = position.longitude.toString();
      log('lat: ${lat.value} long: ${long.value}');
      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
      // if (position.isMocked) {
      //   dialogWidget(
      //     type: 'error',
      //     title: "Lokasi Palsu Terdeteksi",
      //     message:
      //         "Lokasi anda terdeteksi menggunakan aplikasi lokasi palsu. Mohon matikan aplikasi tersebut dan coba lagi.",
      //     onPressed: () {
      //       Get.offAllNamed("/navbar");
      //     },
      //   );
      //   return;
      // }
    } catch (e) {
      log(e.toString());
    }
    isLoadingMap.value = false;
  }
}
