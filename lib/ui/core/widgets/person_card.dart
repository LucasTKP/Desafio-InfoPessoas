import 'package:flutter/material.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';
import 'package:infopessoas/ui/core/themes/theme_colors.dart';
import 'package:infopessoas/ui/core/widgets/custom_circular_progress.dart';

class PersonCard extends StatelessWidget {
  final PersonModel person;
  final VoidCallback? onTap;
  final Widget trailing;
  const PersonCard({
    super.key,
    required this.person,
    this.onTap,
    this.trailing = const Icon(
      Icons.arrow_forward_ios,
      size: 24,
      color: Colors.black45,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFFD4D4D8),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,

        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              person.pictureUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CustomCircularProgress(size: 35),
                );
              },
            ),
          ),
        ),
        title: Text(
          person.fullName,
          style: context.textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          '${person.dob.age} anos',
          style: context.textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: trailing,
      ),
    );
  }
}
