import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';

class MaterialBannerService {
  Timer? _timer;

  void showBanner({
    required BuildContext context,
    required String message,
    required Color color,
    int duration = 3500,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    _timer?.cancel();
    scaffoldMessenger.clearMaterialBanners();

    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),

        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              _timer?.cancel();
              scaffoldMessenger.hideCurrentMaterialBanner();
            },
          ),
        ],
      ),
    );

    _timer = Timer(Duration(milliseconds: duration), () {
      scaffoldMessenger.hideCurrentMaterialBanner();
    });
  }
}
