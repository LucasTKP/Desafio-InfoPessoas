import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/widgets/custom_circular_progress.dart';

class FavoriteButton extends StatefulWidget {
  final Future<void> Function() onTap;

  const FavoriteButton({super.key, required this.onTap});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onTap();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading ? null : _handleTap,
      icon: _isLoading ? CustomCircularProgress(size: 20) : Icon(Icons.favorite, color: Colors.red),
    );
  }
}
