import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusBroken.search_normal_1,
            size: 50,
            color: black.withOpacity(0.5),
          ),
          const SizedBox(height: 10),
          Text(
            'Oops, tidak ada data!',
            style: TextStyle(
              fontWeight: bold,
            ),
          ),
          TextButton(
            onPressed: () => Get.forceAppUpdate(),
            child: Text('Refresh'),
          )
        ],
      ),
    );
  }
}
