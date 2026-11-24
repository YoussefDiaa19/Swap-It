import 'package:flutter/material.dart';

/// Dismissible top banner indicating guest browsing mode with quick sign-in action.
class GuestBanner extends StatefulWidget {
  final VoidCallback? onSignInTap;

  const GuestBanner({super.key, this.onSignInTap});

  @override
  State<GuestBanner> createState() => _GuestBannerState();
}

class _GuestBannerState extends State<GuestBanner> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Color(0xFF4B5563),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF374151),
                ),
                children: [
                  const TextSpan(text: 'Browsing as Guest · '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: widget.onSignInTap ?? () {},
                      child: const Text(
                        'Sign in to swap',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = false;
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.close,
                size: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
