import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/theme_colors.dart';
import 'package:infopessoas/ui/core/widgets/custom_circular_progress.dart';

class ButtonFavorite extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final bool isFavorite;
  const ButtonFavorite({super.key, required this.isLoading, required this.onPressed, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isLoading ? null : onPressed,
      child: icon(),
    );
  }

  Widget icon() {
    if (isLoading) {
      return const CustomCircularProgress(size: 30, color: ThemeColors.white);
    } else if (isFavorite) {
      return const Icon(Icons.favorite, color: Colors.white);
    } else {
      return const Icon(Icons.favorite_border);
    }
  }
}
