import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';
import 'package:infopessoas/ui/core/themes/theme_colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? color;
  final double width;
  final double height;
  final Icon? icon;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = ThemeColors.primary,
    this.width = double.infinity,
    this.height = 48,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(label, style: context.textTheme.titleMedium?.copyWith(color: ThemeColors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
