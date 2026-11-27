import 'package:flutter/material.dart';
import '../create_listing/create_listing_page.dart';
import '../home/item_details_page.dart';
import '../home/models/swap_item.dart';
import '../home/widgets/item_card.dart';
import 'favorites_controller.dart';
import 'widgets/favorites_empty_state.dart';

/// Favorites and bookmarked items screen.
///
/// - 2-column grid of saved items (reuses the Home [ItemCard])
/// - Empty state when nothing is saved
/// - Un-favorite with an "Undo" snackbar
/// - Entry point to the "List an Item" form
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesController _controller = FavoritesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetails(SwapItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemDetailsPage(item: item)),
    );
  }

  void _openCreateListing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateListingPage()),
    );
  }

  void _removeFavorite(SwapItem item) {
    final index = _controller.remove(item.id);
    if (index == -1) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Removed ${item.shortTitle} from favorites'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => _controller.restore(item, index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            tooltip: 'List an Item',
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: _openCreateListing,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.isEmpty) {
            return FavoritesEmptyState(onListItemTap: _openCreateListing);
          }
          final items = _controller.items;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.64,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCard(
                item: item,
                onTap: () => _openDetails(item),
                onFavoriteTap: () => _removeFavorite(item),
              );
            },
          );
        },
      ),
    );
  }
}
