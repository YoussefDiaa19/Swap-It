import 'package:flutter/material.dart';

/// Shown when the user has not saved any items yet.
class FavoritesEmptyState extends StatelessWidget {
  final VoidCallback onListItemTap;

  const FavoritesEmptyState({
    super.key,
    required this.onListItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 40,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No saved items yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart on any item to save it here for later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onListItemTap,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('List an Item'),
            ),
          ],
        ),
      ),
    );
  }
}
