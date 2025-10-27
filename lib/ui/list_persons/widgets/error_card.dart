import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';
import 'package:infopessoas/ui/core/widgets/default_button.dart';

class ErrorCard extends StatelessWidget {
  final VoidCallback tryAgain;
  final ValueNotifier<String?> error;
  const ErrorCard({super.key, required this.tryAgain, required this.error});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: error,
      builder: (context, value, child) {
        final errorMessage = error.value;

        if (errorMessage == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
              SizedBox(height: 8),
              DefaultButton(
                onPressed: tryAgain,
                label: "Tentar novamente",
                color: Colors.red[700],
              ),
            ],
          ),
        );
      },
    );
  }
}
