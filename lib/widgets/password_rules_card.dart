import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_chaos_new/providers/game_provider.dart';

class PasswordRulesCard extends ConsumerWidget {
  const PasswordRulesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final rules = gameState.currentRules;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.rule, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Current Rules',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (!gameState.hasUsedHint)
                  IconButton(
                    icon: const Icon(Icons.lightbulb_outline),
                    onPressed: () {
                      ref.read(gameProvider.notifier).useHint();
                    },
                    tooltip: 'Get a hint',
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...rules.map((rule) {
              final isValid = gameState.ruleValidation[rule] ?? false;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isValid ? Icons.check_circle : Icons.check_circle_outline,
                      size: 20,
                      color: isValid
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rule.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (gameState.hasUsedHint && rule.hint != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                rule.hint!,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(delay: 200.ms);
  }
}
