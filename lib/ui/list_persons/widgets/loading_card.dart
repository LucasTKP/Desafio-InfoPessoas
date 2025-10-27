import 'package:flutter/material.dart';
import 'package:infopessoas/ui/core/widgets/custom_circular_progress.dart';

class LoadingCard extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  const LoadingCard({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        if (value == false) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CustomCircularProgress()),
        );
      },
    );
  }
}
