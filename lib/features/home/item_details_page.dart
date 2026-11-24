import 'package:flutter/material.dart';
import '../../core/widgets/user_avatar.dart';
import 'models/swap_item.dart';
import 'widgets/swap_item_image.dart';

/// Item details screen matching Image 2 exactly.
///
/// Features:
/// - Breadcrumb bar & quick actions (share, more)
/// - Hero dark photo gallery with verified gear badge & magnification tag
/// - Condition badge + location + timestamp
/// - Ranked 3-priority wishlist cards with cash offset notice
/// - 2x2 specification badges (Category, Brand, Estimated Value, Year)
/// - Full item description
/// - SwapIt Escrow Guarantee banner
/// - Verified owner profile card with PRO badge and rating
/// - Sticky bottom bar with Favorite toggle and "Propose a Swap" button
class ItemDetailsPage extends StatefulWidget {
  final SwapItem item;

  const ItemDetailsPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late bool _isFavorite;
  final int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.item.isFavorite;
  }

  void _onProposeSwapTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Icon(
                  Icons.swap_horiz_rounded,
                  color: Color(0xFF111827),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Propose a Swap',
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select an item from your listed belongings to offer to ${widget.item.ownerUsername} for their ${widget.item.title}.',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Choose from "My Listed Items"',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Swap proposal initiated for ${widget.item.title}!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: const Color(0xFF111827),
                    ),
                  );
                },
                child: const Text(
                  'Continue with Proposal',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Item Details',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 17,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: UserAvatar(
              imageUrl:
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
              size: 32,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs & Quick actions row
            _buildBreadcrumbBar(item),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),

                  // Hero Photo Showcase with Overlays
                  _buildPhotoShowcase(item),

                  const SizedBox(height: 18),

                  // Title
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.4,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Condition pill + Location and timestamp
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.conditionDetail,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${item.location} · ${item.timeAgo}',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // "LOOKING TO SWAP FOR:" Section
                  _buildLookingForSection(item),

                  const SizedBox(height: 22),

                  // Specs 2x2 Grid
                  _buildSpecsGrid(item),

                  const SizedBox(height: 22),

                  // Item Description Section
                  const Text(
                    'Item Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF374151),
                      height: 1.55,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SwapIt Escrow Guarantee Box
                  _buildEscrowGuaranteeBox(),

                  const SizedBox(height: 18),

                  // User / Owner Profile Card
                  _buildOwnerCard(item),

                  const SizedBox(height: 14),

                  // Verified trade disclaimer
                  const Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 15,
                        color: Color(0xFF9CA3AF),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Trades on SwapIt are 100% peer-to-peer verified. Always review trade receipts.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      // Sticky Bottom Action Bar
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  /// Breadcrumb bar with Home > Title and share/more buttons
  Widget _buildBreadcrumbBar(SwapItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 14,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Home > ${item.title}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B5563),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item link copied to clipboard!')),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.more_vert_rounded,
                  size: 20,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Dark background hero photo card with Verified Gear, Magnification tag,
  /// and carousel page dots.
  Widget _buildPhotoShowcase(SwapItem item) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF18181B), // Dark sleek background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Center Item Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SwapItemImage(
                imageUrl: item.imageUrl,
                height: 270,
                fit: BoxFit.contain,
                fallbackIcon: Icons.camera_alt_rounded,
              ),
            ),
          ),

          // Top-Left: "✔ Verified Gear" Pill
          if (item.isVerifiedGear)
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 0.8,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 13,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Verified Gear',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Top-Right: Feature Pill (e.g. "0.72x Magnification")
          if (item.featureBadge != null)
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  item.featureBadge!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // Bottom-Center: Carousel Indicator Dots (4 dots)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index == _currentImageIndex;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 7 : 6,
                  height: isActive ? 7 : 6,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  /// "LOOKING TO SWAP FOR:" section with ranked priorities and cash offset note
  Widget _buildLookingForSection(SwapItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  size: 18,
                  color: Color(0xFF111827),
                ),
                SizedBox(width: 6),
                Text(
                  'LOOKING TO SWAP FOR:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
              ),
              child: Text(
                '${item.priorities.length} Priorities',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Priorities List Cards
        ...item.priorities.map((priority) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rank number badge (e.g. 1, 2, 3)
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 1, right: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF111827),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${priority.rank}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Title + Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          priority.title,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          priority.subtitle,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        if (item.cashOffsetAllowed) ...[
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(
                Icons.payments_outlined,
                size: 15,
                color: Color(0xFF6B7280),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Cash offset open for the right trade balance.',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// 2x2 specification badges (Category, Brand, Value Est., Year)
  Widget _buildSpecsGrid(SwapItem item) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSpecBox('Category:', item.category),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildSpecBox('Brand:', item.brand),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildSpecBox('Value Est.:', item.estimatedValue),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildSpecBox('Year:', item.yearOrModel),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
      ),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: const TextStyle(fontSize: 12),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SwapIt Escrow Guarantee banner box
  Widget _buildEscrowGuaranteeBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 22,
            color: Color(0xFF111827),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SwapIt Escrow Guarantee',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Inspected before exchange release',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('SwapIt Escrow: All trades are physically inspected before release.'),
                ),
              );
            },
            child: const Text(
              'Learn',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Owner profile card with avatar, rating, and View Profile button
  Widget _buildOwnerCard(SwapItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
      ),
      child: Row(
        children: [
          // Circular Avatar
          UserAvatar(
            imageUrl: item.ownerAvatarUrl,
            size: 44,
          ),
          const SizedBox(width: 12),

          // Owner Name, PRO badge and Rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.ownerUsername,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    if (item.isProOwner) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Color(0xFF111827),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        '${item.ownerRating} (${item.ownerSwapsCount} swaps) · ${item.memberSince}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // View Profile Outlined Button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: const Size(0, 32),
              side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${item.ownerUsername}\'s full profile')),
              );
            },
            child: const Text(
              'View Profile',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sticky Bottom Action Bar with Heart and Propose a Swap button
  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Heart Favorite Button
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isFavorite ? 'Saved to Favorites' : 'Removed from Favorites',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _isFavorite ? const Color(0xFFDC2626) : const Color(0xFF111827),
                  size: 22,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Prominent "Propose a Swap" Button
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111827),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _onProposeSwapTap,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horiz_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Propose a Swap',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
