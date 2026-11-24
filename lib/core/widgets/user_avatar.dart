import 'package:flutter/material.dart';

/// Reusable user avatar with graceful fallback for network / offline environments.
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final Border? border;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.size = 34,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        shape: BoxShape.circle,
        border: border ?? Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildFallback(),
              )
            : _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    return Icon(
      Icons.person_rounded,
      size: size * 0.65,
      color: const Color(0xFF4B5563),
    );
  }
}
