import 'package:flutter/foundation.dart';
import '../home/models/mock_swap_items.dart';
import '../home/models/swap_item.dart';

/// Holds the list of saved (favorited) items for the Favorites screen.
///
/// Seeded with a few mock items until a real data layer exists.
class FavoritesController extends ChangeNotifier {
  FavoritesController()
      : _items = mockSwapItems
            .take(3)
            .map((item) => item.copyWith(isFavorite: true))
            .toList();

  final List<SwapItem> _items;

  List<SwapItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  /// Removes a saved item and returns its previous index (or -1 if absent).
  int remove(String itemId) {
    final index = _items.indexWhere((i) => i.id == itemId);
    if (index == -1) return -1;
    _items.removeAt(index);
    notifyListeners();
    return index;
  }

  /// Re-inserts an item (used by the "Undo" action).
  void restore(SwapItem item, int index) {
    final safeIndex = index > _items.length ? _items.length : index;
    _items.insert(safeIndex, item);
    notifyListeners();
  }
}
