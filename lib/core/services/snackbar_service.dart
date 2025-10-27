import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';

class MaterialBannerService {
  void showMessage({
    required BuildContext context,
    required String message,
    required Color color,
    int duration = 3500,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearMaterialBanners();

    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),

        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              scaffoldMessenger.hideCurrentMaterialBanner();
            },
          ),
        ],
      ),
    );

    Future.delayed(Duration(milliseconds: duration), () {
      scaffoldMessenger.hideCurrentMaterialBanner();
    });
  }
}
