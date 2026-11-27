import 'package:flutter/material.dart';

/// Single-select chip group used for Category and Condition.
class ChoiceChipsField extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelected;

  const ChoiceChipsField({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final option in options)
          ChoiceChip(
            label: Text(option),
            selected: option == selected,
            showCheckmark: false,
            onSelected: (_) => onSelected(option),
            backgroundColor: const Color(0xFFF3F4F6),
            selectedColor: const Color(0xFF111827),
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: option == selected
                  ? Colors.white
                  : const Color(0xFF374151),
            ),
            side: BorderSide(
              color: option == selected
                  ? const Color(0xFF111827)
                  : const Color(0xFFE5E7EB),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
      ],
    );
  }
}
