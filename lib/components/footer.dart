import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context)
                .dividerColor
                .withValues(alpha: 0.25),
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 6,
        children: [
          Text(
            "© ${DateTime.now().year} Bhupender.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.60),
                ),
          ),

          Text(
            "Built with",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.60),
                ),
          ),

          Icon(
            Icons.favorite_rounded,
            color: primary,
            size: 17,
          ),

          Text(
            "using Flutter",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.60),
                ),
          ),
        ],
      ),
    );
  }
}