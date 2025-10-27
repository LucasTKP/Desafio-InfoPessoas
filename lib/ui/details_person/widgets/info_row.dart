import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';

class InfoRowCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const InfoRowCard({super.key, required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(value, style: context.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
