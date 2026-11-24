import 'package:flutter/material.dart';

/// Section title row with "Recent Drops", "Verified" subtitle/tag,
/// and "Filters (2)" action button.
class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final int filterCount;
  final VoidCallback? onFiltersTap;

  const SectionHeader({
    super.key,
    this.title = 'Recent Drops',
    this.subtitle = 'Verified',
    this.filterCount = 2,
    this.onFiltersTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section Title + Verified subtitle
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),

          // Filters (2) pill button
          GestureDetector(
            onTap: onFiltersTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.filter_list_rounded,
                    size: 14,
                    color: Color(0xFF374151),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Filters ($filterCount)',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
