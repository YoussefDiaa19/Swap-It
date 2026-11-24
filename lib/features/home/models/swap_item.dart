/// Represents a specific trade priority item that the owner is seeking.
class SwapPriority {
  final int rank; // 1, 2, 3
  final String title;
  final String subtitle;

  const SwapPriority({
    required this.rank,
    required this.title,
    required this.subtitle,
  });
}

/// Key product specification (e.g. Category, Brand, Value Est., Year).
class ItemSpec {
  final String label;
  final String value;

  const ItemSpec({
    required this.label,
    required this.value,
  });
}

/// Data model representing a peer-to-peer item available for trade.
class SwapItem {
  final String id;
  final String title;
  final String shortTitle;
  final String condition; // e.g. "MINT", "LIKE NEW", "EXCELLENT", "GOOD"
  final String conditionDetail; // e.g. "MINT CONDITION"
  final String location; // e.g. "Brooklyn, NY"
  final String timeAgo; // e.g. "2h ago"
  final String imageUrl;
  final List<String> additionalImages;
  final bool isVerifiedGear;
  final String? featureBadge; // e.g. "0.72x Magnification"
  final String category; // e.g. "Photography", "Electronics", "Fashion"
  final String brand;
  final String estimatedValue;
  final String yearOrModel;
  final String description;
  final String ownerUsername; // e.g. "@marcus_c"
  final String ownerName;
  final String? ownerAvatarUrl;
  final bool isProOwner;
  final double ownerRating;
  final int ownerSwapsCount;
  final String memberSince;
  final String wishlistSummary; // e.g. "Sony A7 IV or Fuji X100V"
  final List<SwapPriority> priorities;
  final bool cashOffsetAllowed;
  final bool isFavorite;

  const SwapItem({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.condition,
    required this.conditionDetail,
    required this.location,
    required this.timeAgo,
    required this.imageUrl,
    this.additionalImages = const [],
    this.isVerifiedGear = false,
    this.featureBadge,
    required this.category,
    required this.brand,
    required this.estimatedValue,
    required this.yearOrModel,
    required this.description,
    required this.ownerUsername,
    required this.ownerName,
    this.ownerAvatarUrl,
    this.isProOwner = false,
    this.ownerRating = 5.0,
    this.ownerSwapsCount = 0,
    required this.memberSince,
    required this.wishlistSummary,
    this.priorities = const [],
    this.cashOffsetAllowed = true,
    this.isFavorite = false,
  });

  /// Copy with helper for UI toggles (like favoriting)
  SwapItem copyWith({
    bool? isFavorite,
  }) {
    return SwapItem(
      id: id,
      title: title,
      shortTitle: shortTitle,
      condition: condition,
      conditionDetail: conditionDetail,
      location: location,
      timeAgo: timeAgo,
      imageUrl: imageUrl,
      additionalImages: additionalImages,
      isVerifiedGear: isVerifiedGear,
      featureBadge: featureBadge,
      category: category,
      brand: brand,
      estimatedValue: estimatedValue,
      yearOrModel: yearOrModel,
      description: description,
      ownerUsername: ownerUsername,
      ownerName: ownerName,
      ownerAvatarUrl: ownerAvatarUrl,
      isProOwner: isProOwner,
      ownerRating: ownerRating,
      ownerSwapsCount: ownerSwapsCount,
      memberSince: memberSince,
      wishlistSummary: wishlistSummary,
      priorities: priorities,
      cashOffsetAllowed: cashOffsetAllowed,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
