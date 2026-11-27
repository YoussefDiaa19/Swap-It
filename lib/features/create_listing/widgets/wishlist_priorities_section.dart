import 'package:flutter/material.dart';

/// Three ranked "what I'd swap for" inputs. Priority #1 is required.
class WishlistPrioritiesSection extends StatelessWidget {
  final List<TextEditingController> controllers;

  const WishlistPrioritiesSection({
    super.key,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < controllers.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == controllers.length - 1 ? 0 : 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF111827),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: controllers[i],
                    textInputAction: i == controllers.length - 1
                        ? TextInputAction.done
                        : TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: i == 0
                          ? 'Top choice (required)'
                          : 'Priority ${i + 1} (optional)',
                    ),
                    validator: i == 0
                        ? (value) => (value == null || value.trim().isEmpty)
                            ? 'Add at least one item you want in return'
                            : null
                        : null,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
