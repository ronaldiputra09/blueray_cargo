import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/modules/home/controllers/home_controller.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends GetView {
  MapView({super.key});
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Lokasi'),
        centerTitle: true,
      ),
      bottomNavigationBar: footer(),
      body: body(),
    );
  }

  Widget body() {
    return Obx(
      () => Container(
        height: Get.height,
        color: white,
        child: homeC.lat.isEmpty
            ? const Center(
                child: Text(
                  "Tidak dapat menemukan lokasi,\nsilahkan cek perizinan lokasi anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            : GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  homeC.mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(homeC.lat.value),
                    double.parse(homeC.long.value),
                  ),
                  zoom: 16,
                ),
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(
                      double.parse(homeC.lat.value),
                      double.parse(homeC.long.value),
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                    infoWindow: InfoWindow(
                      title: "Lokasi Anda",
                      snippet: "${homeC.lat.value},${homeC.long.value}",
                    ),
                  ),
                },
                onTap: (LatLng latLng) {
                  homeC.lat.value = latLng.latitude.toString();
                  homeC.long.value = latLng.longitude.toString();
                  homeC.getNamePlace();
                  homeC.mapController?.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(latLng.latitude, latLng.longitude),
                    ),
                  );
                },
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
          title: 'Pilih Lokasi',
          loading: homeC.isLoading.value,
          onPressed: () {
            Get.back();
            homeC.getNamePlace();
          },
        ),
      ),
    );
  }
}
