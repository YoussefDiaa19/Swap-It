import 'package:flutter/material.dart';
import '../../../core/widgets/user_avatar.dart';

/// Top bar with brand logo, items counter, and notification bell
class HomeHeader extends StatelessWidget {
  final int itemsCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileAvatarTap;

  const HomeHeader({
    super.key,
    this.itemsCount = 38,
    this.onNotificationTap,
    this.onProfileAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top App Bar row with SwapIt logo, title and profile avatar
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: Swap icon + SwapIt text
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_horiz_rounded,
                    color: Color(0xFF111827),
                    size: 26,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'SwapIt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),

              // Center: SWAPIT text
              const Text(
                'SWAPIT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF111827),
                  letterSpacing: 1.2,
                ),
              ),

              // Right: Profile Avatar
              GestureDetector(
                onTap: onProfileAvatarTap,
                child: const UserAvatar(
                  imageUrl:
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                  size: 34,
                ),
              ),
            ],
          ),
        ),

        // Subheader row: "● 38 ITEMS LISTED TODAY" + Notification Bell
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Items counter with leading dot
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF111827),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$itemsCount ITEMS LISTED TODAY',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),

              // Notification bell with red badge dot
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        size: 20,
                        color: Color(0xFF111827),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF111827),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
