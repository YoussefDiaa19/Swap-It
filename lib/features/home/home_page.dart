import 'package:flutter/material.dart';
import 'item_details_page.dart';
import 'models/mock_swap_items.dart';
import 'models/swap_item.dart';
import 'widgets/category_selector.dart';
import 'widgets/guest_banner.dart';
import 'widgets/home_header.dart';
import 'widgets/item_card.dart';
import 'widgets/search_filter_bar.dart';
import 'widgets/section_header.dart';

/// Clean, modular Home Screen matching the design in Image 1.
///
/// Organized cleanly using decoupled sub-widgets:
/// - [HomeHeader]: Brand title, item counter, notification button, avatar
/// - [GuestBanner]: Dismissible guest notification
/// - [SearchFilterBar]: Modern pill search and tuning filter
/// - [CategorySelector]: Category pill chips with reactive filtering
/// - [SectionHeader]: "Recent Drops" title and filter button
/// - [ItemCard]: 2-column grid cards with condition badges & wishlist preview
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<SwapItem> _items;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _items = List.from(mockSwapItems);
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _toggleFavorite(String itemId) {
    setState(() {
      final index = _items.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        final current = _items[index];
        _items[index] = current.copyWith(isFavorite: !current.isFavorite);
      }
    });
  }

  void _navigateToDetails(SwapItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailsPage(item: item),
      ),
    );
  }

  List<SwapItem> get _filteredItems {
    return _items.where((item) {
      final matchesCategory = _selectedCategory == 'All' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery) ||
          item.description.toLowerCase().contains(_searchQuery) ||
          item.wishlistSummary.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar + Subheader row
            SliverToBoxAdapter(
              child: HomeHeader(
                itemsCount: 38,
                onNotificationTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No new notifications today')),
                  );
                },
                onProfileAvatarTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing current profile')),
                  );
                },
              ),
            ),

            // Dismissible Guest Banner
            SliverToBoxAdapter(
              child: GuestBanner(
                onSignInTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign-in bottom sheet placeholder')),
                  );
                },
              ),
            ),

            // Search Filter Bar
            SliverToBoxAdapter(
              child: SearchFilterBar(
                onChanged: _onSearchChanged,
                onFilterTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter options opened')),
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 6),
            ),

            // Horizontal Category Selector
            SliverToBoxAdapter(
              child: CategorySelector(
                selectedCategory: _selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),

            // "Recent Drops" Section Header
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Recent Drops',
                subtitle: 'Verified',
                filterCount: 2,
                onFiltersTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter presets applied')),
                  );
                },
              ),
            ),

            // 2-Column Grid of Item Cards
            if (filtered.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'No items found matching your filters.\nTry selecting "All" or a different category.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.64,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = filtered[index];
                      return ItemCard(
                        item: item,
                        onTap: () => _navigateToDetails(item),
                        onFavoriteTap: () => _toggleFavorite(item.id),
                      );
                    },
                    childCount: filtered.length,
                  ),
                ),
              ),

            // Bottom Spacing for scrolling clearance
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
