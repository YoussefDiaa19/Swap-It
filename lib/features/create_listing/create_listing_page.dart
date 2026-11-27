import 'package:flutter/material.dart';
import '../home/models/swap_item.dart';
import 'widgets/choice_chips_field.dart';
import 'widgets/photo_upload_section.dart';
import 'widgets/wishlist_priorities_section.dart';

/// "List an Item" form.
///
/// Sections: photos (placeholder), title, category, condition, description,
/// wishlist priorities and cash-offset toggle. On a valid submit the page
/// pops with the newly built [SwapItem] as its result.
class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  static const List<String> _categories = [
    'Electronics',
    'Fashion',
    'Books',
    'Home',
    'Photography',
  ];
  static const List<String> _conditions = [
    'MINT',
    'LIKE NEW',
    'EXCELLENT',
    'GOOD',
    'FAIR',
  ];
  static const int _maxPhotos = 5;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _priorityControllers =
      List.generate(3, (_) => TextEditingController());

  int _photoCount = 0;
  String? _category;
  String? _condition;
  bool _cashOffsetAllowed = true;
  bool _showSelectionErrors = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final c in _priorityControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addPhoto() {
    if (_photoCount >= _maxPhotos) return;
    setState(() => _photoCount++);
  }

  void _removePhoto(int index) {
    setState(() => _photoCount--);
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final selectionsValid = _category != null && _condition != null;
    setState(() => _showSelectionErrors = true);
    if (!formValid || !selectionsValid) return;

    final priorities = <SwapPriority>[];
    for (int i = 0; i < _priorityControllers.length; i++) {
      final text = _priorityControllers[i].text.trim();
      if (text.isNotEmpty) {
        priorities.add(
          SwapPriority(rank: priorities.length + 1, title: text, subtitle: ''),
        );
      }
    }

    final title = _titleController.text.trim();
    final item = SwapItem(
      id: 'item_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      shortTitle: title.length > 12 ? '${title.substring(0, 12)}...' : title,
      condition: _condition!,
      conditionDetail: '${_condition!} CONDITION',
      location: 'Your location',
      timeAgo: 'Just now',
      imageUrl: '',
      category: _category!,
      brand: '-',
      estimatedValue: '-',
      yearOrModel: '-',
      description: _descriptionController.text.trim(),
      ownerUsername: '@you',
      ownerName: 'You',
      memberSince: 'Member 2026',
      wishlistSummary: priorities.map((p) => p.title).join(' or '),
      priorities: priorities,
      cashOffsetAllowed: _cashOffsetAllowed,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$title" listed successfully!')),
    );
    Navigator.pop(context, item);
  }

  Widget _label(String text, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          if (hint != null) ...[
            const SizedBox(width: 8),
            Text(
              hint,
              style: const TextStyle(fontSize: 11.5, color: Color(0xFF9CA3AF)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _selectionError(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        message,
        style: const TextStyle(fontSize: 12, color: Color(0xFFDC2626)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('List an Item'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _label('Photos', hint: 'Up to $_maxPhotos'),
            PhotoUploadSection(
              photoCount: _photoCount,
              maxPhotos: _maxPhotos,
              onAdd: _addPhoto,
              onRemove: _removePhoto,
            ),
            const SizedBox(height: 22),
            _label('Title'),
            TextFormField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'e.g. Leica M6 Black Chrome',
              ),
              validator: (value) =>
                  (value == null || value.trim().isEmpty)
                      ? 'Please enter a title'
                      : null,
            ),
            const SizedBox(height: 22),
            _label('Category'),
            ChoiceChipsField(
              options: _categories,
              selected: _category,
              onSelected: (v) => setState(() => _category = v),
            ),
            if (_showSelectionErrors && _category == null)
              _selectionError('Please choose a category'),
            const SizedBox(height: 22),
            _label('Condition'),
            ChoiceChipsField(
              options: _conditions,
              selected: _condition,
              onSelected: (v) => setState(() => _condition = v),
            ),
            if (_showSelectionErrors && _condition == null)
              _selectionError('Please choose a condition'),
            const SizedBox(height: 22),
            _label('Description'),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: 'Describe the item, any flaws, what is included...',
              ),
            ),
            const SizedBox(height: 10),
            _label('Wishlist priorities', hint: 'What would you swap for?'),
            WishlistPrioritiesSection(controllers: _priorityControllers),
            const SizedBox(height: 14),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _cashOffsetAllowed,
              onChanged: (v) => setState(() => _cashOffsetAllowed = v),
              title: const Text(
                'Allow cash offset',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Accept a small cash top-up to balance the trade value.',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                ),
                onPressed: _submit,
                child: const Text('Publish Listing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
