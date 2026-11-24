import 'package:flutter/material.dart';

/// Clean rounded search bar with search icon and filter tuning action.
class SearchFilterBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const SearchFilterBar({
    super.key,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: Color(0xFF9CA3AF),
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search items to swap...',
                  hintStyle: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: onFilterTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.tune_rounded,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
