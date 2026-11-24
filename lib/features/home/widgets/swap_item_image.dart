import 'package:flutter/material.dart';

/// Reusable item image component that handles network loading gracefully
/// and falls back to a clean minimalist graphic placeholder if offline or loading.
class SwapItemImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final IconData fallbackIcon;

  const SwapItemImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.fallbackIcon = Icons.inventory_2_outlined,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholderContainer(
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      );
    } else {
      imageWidget = _buildFallback();
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholderContainer({required Widget child}) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFF3F4F6),
      child: child,
    );
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFF3F4F6),
      child: Center(
        child: Icon(
          fallbackIcon,
          size: 36,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}
