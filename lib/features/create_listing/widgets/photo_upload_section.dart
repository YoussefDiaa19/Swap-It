import 'package:flutter/material.dart';

/// Photo upload placeholder. No picker is wired yet: tapping "Add" simply
/// adds a placeholder tile (max [maxPhotos]).
class PhotoUploadSection extends StatelessWidget {
  final int photoCount;
  final int maxPhotos;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  const PhotoUploadSection({
    super.key,
    required this.photoCount,
    required this.onAdd,
    required this.onRemove,
    this.maxPhotos = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (photoCount < maxPhotos) _buildAddTile(),
          for (int i = 0; i < photoCount; i++) _buildPhotoTile(i),
        ],
      ),
    );
  }

  Widget _buildAddTile() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onAdd,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 96,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_outlined, color: Color(0xFF4B5563)),
              SizedBox(height: 6),
              Text(
                'Add photo',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoTile(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Center(
              child: Icon(
                index == 0 ? Icons.star_rounded : Icons.image_outlined,
                color: const Color(0xFF9CA3AF),
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => onRemove(index),
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color(0xFF111827),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
